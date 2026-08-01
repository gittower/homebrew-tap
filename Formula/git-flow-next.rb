class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "1.2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.2.0/git-flow-next-v1.2.0-darwin-amd64.tar.gz"
      sha256 "ffb8e9ac8458ab34e79feecd21d2292429e92123961c7820399540b0fe621889"
      def install
        bin.install "git-flow-v1.2.0-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.2.0/git-flow-next-v1.2.0-darwin-arm64.tar.gz"
      sha256 "20456ff5820b4b3a6b287ef0ddad0463b2f6fb4295ab2791877f0288d0d6ec9e"
      def install
        bin.install "git-flow-v1.2.0-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.2.0/git-flow-next-v1.2.0-linux-amd64.tar.gz"
      sha256 "04f8c66588751907a9149a107d97ef4fa190252799ffd644e711040c96209bc1"
      def install
        bin.install "git-flow-v1.2.0-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.2.0/git-flow-next-v1.2.0-linux-arm64.tar.gz"
      sha256 "a80d3d68ea4797adbfd02687edaccb5d175a1df5ecbebace277bb6b75a0cd004"
      def install
        bin.install "git-flow-v1.2.0-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end