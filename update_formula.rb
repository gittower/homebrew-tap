#!/usr/bin/env ruby

# Formula Update Automation Script
#
# This script automates the process of updating the git-flow-next Homebrew formula
# by fetching the latest release information from GitHub and updating checksums.
#
# Process:
# 1. Fetches the latest version tag (starting with 'v', following semantic versioning)
#   from https://github.com/gittower/git-flow-next/
# 2. Downloads the checksums file from the release:
#   https://github.com/gittower/git-flow-next/releases/download/<version>/git-flow-next-<version>-checksums.txt
# 3. Extracts SHA256 checksums for the required platform archive files:
#   - git-flow-next-<version>-darwin-amd64.tar.gz
#   - git-flow-next-<version>-darwin-arm64.tar.gz  
#   - git-flow-next-<version>-linux-amd64.tar.gz
#   - git-flow-next-<version>-linux-arm64.tar.gz
# 4. Updates the formula template with the new version and checksums
# 5. Commits the changes with message "Update to <version>"
#
# Download URLs follow the pattern:
# https://github.com/gittower/git-flow-next/releases/download/<version>/<file>

require 'net/http'
require 'uri'
require 'json'
require 'optparse'

def fetch_url(url)
  uri = URI(url)
  
  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    
    case response
    when Net::HTTPRedirection
      fetch_url(response['location'])
    when Net::HTTPSuccess
      response
    else
      puts "Error fetching #{url}: #{response.code} #{response.message}"
      exit 1
    end
  end
end

REPO_URL = 'https://api.github.com/repos/gittower/git-flow-next'
TEMPLATE_FILE = 'Formula/git-flow-next.rb.template'
FORMULA_FILE = 'Formula/git-flow-next.rb'

def get_current_version
  return nil unless File.exist?(FORMULA_FILE)
  
  content = File.read(FORMULA_FILE)
  if match = content.match(/version\s+"([^"]+)"/)
    match[1]
  else
    nil
  end
end

def fetch_latest_release
  response = fetch_url("#{REPO_URL}/releases")
  releases = JSON.parse(response.body)
  
  # Filter releases that start with 'v' and are not drafts
  version_releases = releases.select do |release|
    !release['draft'] && release['tag_name'].start_with?('v')
  end
  
  if version_releases.empty?
    puts "No valid releases found"
    exit 1
  end
  
  # Return the first one (GitHub returns them sorted by creation date, newest first)
  version_releases.first
end

def fetch_checksums(version)
  checksums_url = "https://github.com/gittower/git-flow-next/releases/download/#{version}/git-flow-next-#{version}-checksums.txt"
  response = fetch_url(checksums_url)
  
  checksums = {}
  response.body.each_line do |line|
    line.strip!
    next if line.empty?
    
    parts = line.split(/\s+/, 2)
    next unless parts.length == 2
    
    sha, filename = parts
    checksums[filename] = sha
  end
  
  checksums
end

def update_formula(version, checksums)
  unless File.exist?(TEMPLATE_FILE)
    puts "Template file #{TEMPLATE_FILE} not found"
    exit 1
  end
  
  template = File.read(TEMPLATE_FILE)
  
  # Extract checksums for the archive files we need
  darwin_amd64_sha = checksums["git-flow-next-#{version}-darwin-amd64.tar.gz"]
  darwin_arm64_sha = checksums["git-flow-next-#{version}-darwin-arm64.tar.gz"]
  linux_amd64_sha = checksums["git-flow-next-#{version}-linux-amd64.tar.gz"]
  linux_arm64_sha = checksums["git-flow-next-#{version}-linux-arm64.tar.gz"]
  
  unless darwin_amd64_sha && darwin_arm64_sha && linux_amd64_sha && linux_arm64_sha
    puts "Missing required checksums for version #{version}"
    puts "Available files: #{checksums.keys.join(', ')}"
    exit 1
  end
  
  # Replace placeholders
  formula = template.gsub('{{VERSION}}', version)
                   .gsub('{{DARWIN_AMD64_SHA}}', darwin_amd64_sha)
                   .gsub('{{DARWIN_ARM64_SHA}}', darwin_arm64_sha)
                   .gsub('{{LINUX_AMD64_SHA}}', linux_amd64_sha)
                   .gsub('{{LINUX_ARM64_SHA}}', linux_arm64_sha)
  
  File.write(FORMULA_FILE, formula)
  puts "Updated #{FORMULA_FILE} with version #{version}"
end

def has_git_changes?
  # Check if there are any staged or unstaged changes to the formula file specifically
  system("git diff --quiet #{FORMULA_FILE}") && system("git diff --cached --quiet #{FORMULA_FILE}")
  !$?.success?
end

def commit_changes(version)
  system('git add Formula/git-flow-next.rb')
  
  if has_git_changes?
    system("git commit -m \"Update to #{version}\"")
    puts "Committed changes with message: Update to #{version}"
    true
  else
    puts "No changes detected, skipping commit"
    false
  end
end

def main
  # Parse command line arguments
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options]"
    
    opts.on("-f", "--force", "Force update even if version hasn't changed") do
      options[:force] = true
    end
    
    opts.on("-h", "--help", "Show this help message") do
      puts opts
      exit
    end
  end.parse!

  puts "=== Formula Update Process ==="
  puts
  
  puts "Step 1/6: Checking current version..."
  current_version = get_current_version
  if current_version
    puts "  ✓ Current formula version: #{current_version}"
  else
    puts "  ! No current version found in formula"
  end
  puts
  
  puts "Step 2/6: Fetching latest release from GitHub..."
  release = fetch_latest_release
  latest_version = release['tag_name']
  puts "  ✓ Found latest version: #{latest_version}"
  puts
  
  # Check if update is needed
  if current_version == latest_version && !options[:force]
    puts "✨ Formula is already up-to-date (#{current_version})"
    puts "   Use --force flag to update anyway"
    exit 0
  elsif current_version == latest_version && options[:force]
    puts "⚠️  Forcing update even though version hasn't changed (#{current_version})"
    puts
  end
  
  puts "Step 3/6: Downloading checksums file..."
  checksums_url = "https://github.com/gittower/git-flow-next/releases/download/#{latest_version}/git-flow-next-#{latest_version}-checksums.txt"
  puts "  → Fetching: #{checksums_url}"
  checksums = fetch_checksums(latest_version)
  puts "  ✓ Downloaded checksums for #{checksums.keys.length} files"
  puts
  
  puts "Step 4/6: Extracting required platform checksums..."
  required_files = [
    "git-flow-next-#{latest_version}-darwin-amd64.tar.gz",
    "git-flow-next-#{latest_version}-darwin-arm64.tar.gz", 
    "git-flow-next-#{latest_version}-linux-amd64.tar.gz",
    "git-flow-next-#{latest_version}-linux-arm64.tar.gz"
  ]
  
  required_files.each do |file|
    if checksums[file]
      puts "  ✓ #{file}: #{checksums[file][0..7]}..."
    else
      puts "  ✗ Missing: #{file}"
    end
  end
  puts
  
  puts "Step 5/6: Updating formula template..."
  puts "  → Reading template: #{TEMPLATE_FILE}"
  puts "  → Writing formula: #{FORMULA_FILE}"
  update_formula(latest_version, checksums)
  puts "  ✓ Formula updated successfully"
  puts
  
  puts "Step 6/6: Committing changes to git..."
  puts "  → Staging: #{FORMULA_FILE}"
  puts "  → Checking for changes..."
  
  committed = commit_changes(latest_version)
  
  if committed
    puts "  ✓ Changes committed"
    puts
    puts "🎉 Formula update completed successfully!"
    puts "   Updated from: #{current_version || 'unknown'}"
    puts "   Updated to: #{latest_version}"
    puts "   Formula: #{FORMULA_FILE}"
  else
    puts "  ℹ️  No changes to commit"
    puts
    puts "✨ Formula processing completed"
    puts "   Version: #{latest_version}"
    puts "   Formula: #{FORMULA_FILE}"
    puts "   Note: No changes were detected in the formula file"
  end
end

if __FILE__ == $0
  main
end