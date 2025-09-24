class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.1/git-flow-next-v0.1.1-darwin-amd64.tar.gz"
      sha256 "e4be53b2971acfdc54bb63e4f3b4f6f9e401ee31a61deb48042748a753716683"
      def install
        bin.install "git-flow-v0.1.1-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.1/git-flow-next-v0.1.1-darwin-arm64.tar.gz"
      sha256 "485649fe5d51d6ff77f900ab48e3b22fe206ea3d108d36578c3fdbddc882c265"
      def install
        bin.install "git-flow-v0.1.1-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.1/git-flow-next-v0.1.1-linux-amd64.tar.gz"
      sha256 "ca3876c11891cd720b3a437a0e47952aabfdb5fa2a6bb1dac34f5d8b7bcdc8ba"
      def install
        bin.install "git-flow-v0.1.1-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.1/git-flow-next-v0.1.1-linux-arm64.tar.gz"
      sha256 "2b29fae802e994de05f9700aac76ec6df9e0b1ab402de742de76ac4d0f58045c"
      def install
        bin.install "git-flow-v0.1.1-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end