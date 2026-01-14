class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.3.0/git-flow-next-v0.3.0-darwin-amd64.tar.gz"
      sha256 "86b9f6c942e806f2f0a7e0b708754ece908e8816c364eadd31e37e07342b5739"
      def install
        bin.install "git-flow-v0.3.0-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.3.0/git-flow-next-v0.3.0-darwin-arm64.tar.gz"
      sha256 "8bfa9b8300340c9a7ed80a47909025a54cfe53bea1c8cc31c4b227d20f7c1a03"
      def install
        bin.install "git-flow-v0.3.0-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.3.0/git-flow-next-v0.3.0-linux-amd64.tar.gz"
      sha256 "aa301c5e00ffba14e924c01566f30c58b5b3bf95eb40cf65470d21f1386fcda7"
      def install
        bin.install "git-flow-v0.3.0-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.3.0/git-flow-next-v0.3.0-linux-arm64.tar.gz"
      sha256 "073d11ce645a21f1ea31099f4f6e4372631ca2fced051170a3ccb00effffc27b"
      def install
        bin.install "git-flow-v0.3.0-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end