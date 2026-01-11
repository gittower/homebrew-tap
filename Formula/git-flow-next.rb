class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.2.0/git-flow-next-v0.2.0-darwin-amd64.tar.gz"
      sha256 "e6097915e2ba689656c47f0a315535d55642e323c7f6905001065936deb08a33"
      def install
        bin.install "git-flow-v0.2.0-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.2.0/git-flow-next-v0.2.0-darwin-arm64.tar.gz"
      sha256 "157b7f104cd03d1606054062f8ab0d4d80b906d78aac2f486bc639e4be5651cb"
      def install
        bin.install "git-flow-v0.2.0-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.2.0/git-flow-next-v0.2.0-linux-amd64.tar.gz"
      sha256 "6266dbd047b70c4b1da2bd2f42286848b4639afcf20e16f942023b8a70cee959"
      def install
        bin.install "git-flow-v0.2.0-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.2.0/git-flow-next-v0.2.0-linux-arm64.tar.gz"
      sha256 "a4659db3217b372df7aad6565a1770ae9ab2b1ed77a059c7ecc9845dadf70934"
      def install
        bin.install "git-flow-v0.2.0-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end