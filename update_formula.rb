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

def commit_changes(version)
  system('git add Formula/git-flow-next.rb')
  system("git commit -m \"Update to #{version}\"")
  puts "Committed changes with message: Update to #{version}"
end

def main
  puts "=== Formula Update Process ==="
  puts
  
  puts "Step 1/5: Fetching latest release from GitHub..."
  release = fetch_latest_release
  version = release['tag_name']
  puts "  ✓ Found latest version: #{version}"
  puts
  
  puts "Step 2/5: Downloading checksums file..."
  checksums_url = "https://github.com/gittower/git-flow-next/releases/download/#{version}/git-flow-next-#{version}-checksums.txt"
  puts "  → Fetching: #{checksums_url}"
  checksums = fetch_checksums(version)
  puts "  ✓ Downloaded checksums for #{checksums.keys.length} files"
  puts
  
  puts "Step 3/5: Extracting required platform checksums..."
  required_files = [
    "git-flow-next-#{version}-darwin-amd64.tar.gz",
    "git-flow-next-#{version}-darwin-arm64.tar.gz", 
    "git-flow-next-#{version}-linux-amd64.tar.gz",
    "git-flow-next-#{version}-linux-arm64.tar.gz"
  ]
  
  required_files.each do |file|
    if checksums[file]
      puts "  ✓ #{file}: #{checksums[file][0..7]}..."
    else
      puts "  ✗ Missing: #{file}"
    end
  end
  puts
  
  puts "Step 4/5: Updating formula template..."
  puts "  → Reading template: #{TEMPLATE_FILE}"
  puts "  → Writing formula: #{FORMULA_FILE}"
  update_formula(version, checksums)
  puts "  ✓ Formula updated successfully"
  puts
  
  puts "Step 5/5: Committing changes to git..."
  puts "  → Staging: #{FORMULA_FILE}"
  puts "  → Commit message: \"Update to #{version}\""
  commit_changes(version)
  puts "  ✓ Changes committed"
  puts
  
  puts "🎉 Formula update completed successfully!"
  puts "   Version: #{version}"
  puts "   Formula: #{FORMULA_FILE}"
end

if __FILE__ == $0
  main
end