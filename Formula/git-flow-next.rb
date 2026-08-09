class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "2.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v2.0.0/git-flow-next-v2.0.0-darwin-amd64.tar.gz"
      sha256 "c7cf202e1689261ca0bb0c715a4c74d0ac82ba3f630b3ad234a2a4da4a77cfb2"
      def install
        bin.install "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v2.0.0/git-flow-next-v2.0.0-darwin-arm64.tar.gz"
      sha256 "6b031aaef47a335880004663536e02d3486144a5197385916879e1b7aa3d4187"
      def install
        bin.install "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v2.0.0/git-flow-next-v2.0.0-linux-amd64.tar.gz"
      sha256 "e0b8fa01168b2b8ac8a068cc346c345e4248ce84f4db9b52d3882f1f57eb1c65"
      def install
        bin.install "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v2.0.0/git-flow-next-v2.0.0-linux-arm64.tar.gz"
      sha256 "991b71e5a1f73de2140ee01ad010505556d9017a15e1643210ed4d657dc7a050"
      def install
        bin.install "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "version"
  end
end