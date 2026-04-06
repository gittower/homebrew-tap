class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.1.0/git-flow-next-v1.1.0-darwin-amd64.tar.gz"
      sha256 "1268bec9c499a488254d585bde6754cd4ff8b520cb4c6827f2abbf4a00ba317d"
      def install
        bin.install "git-flow-v1.1.0-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.1.0/git-flow-next-v1.1.0-darwin-arm64.tar.gz"
      sha256 "5a875c5679fd8b0f5fbfa6911817d532b08d88a516ebb6c2319fd7bd0868074d"
      def install
        bin.install "git-flow-v1.1.0-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.1.0/git-flow-next-v1.1.0-linux-amd64.tar.gz"
      sha256 "98a68e6ce525595dc94e3e3ac39d14f095edaad4de8a42513a294c50d9e190df"
      def install
        bin.install "git-flow-v1.1.0-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v1.1.0/git-flow-next-v1.1.0-linux-arm64.tar.gz"
      sha256 "f26e631e6fd6739006aa5a077b250a2a6c1770488832cd8bb31ea9705891c84c"
      def install
        bin.install "git-flow-v1.1.0-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end