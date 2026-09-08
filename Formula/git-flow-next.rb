class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "2.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v2.1.0/git-flow-next-v2.1.0-darwin-amd64.tar.gz"
      sha256 "a7a47251c98cf723aa2a5206b654f1a358f0ab71b778c2ca05ad0e6540578d50"
      def install
        bin.install "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v2.1.0/git-flow-next-v2.1.0-darwin-arm64.tar.gz"
      sha256 "50267d0a64e9e86aef5e936fc39a84eb3e135f841b433d5e2aac713afad8b7f3"
      def install
        bin.install "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v2.1.0/git-flow-next-v2.1.0-linux-amd64.tar.gz"
      sha256 "e335b5818f2b2f820c17844c194030d0db78f3cdfa9bb999fcb9ce092ba9ecd2"
      def install
        bin.install "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v2.1.0/git-flow-next-v2.1.0-linux-arm64.tar.gz"
      sha256 "aea866eb7f9287aedf65795251ef3f556b4c7b677d3aa201f2089ec8ee4166eb"
      def install
        bin.install "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "version"
  end
end