class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.0.0/git-flow-next-v1.0.0-darwin-amd64.tar.gz"
      sha256 "0f1880724467d486d3db2a381ed6e279071f65eb56e36e63741326a5b3d847e5"
      def install
        bin.install "git-flow-v1.0.0-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.0.0/git-flow-next-v1.0.0-darwin-arm64.tar.gz"
      sha256 "85380c99c3874d2d5820ef413840c4f63fa4866c26a5106c6fbb50559b38aa53"
      def install
        bin.install "git-flow-v1.0.0-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.0.0/git-flow-next-v1.0.0-linux-amd64.tar.gz"
      sha256 "62dbc417ecd799f351aee7e389fc99898b31b2bdd77d1ca981407363c130020e"
      def install
        bin.install "git-flow-v1.0.0-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.0.0/git-flow-next-v1.0.0-linux-arm64.tar.gz"
      sha256 "f9a910f90b8a2a3b616acf17ce68e8bf71b0edb0fb353aef5fc9ef2ccb950c83"
      def install
        bin.install "git-flow-v1.0.0-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end