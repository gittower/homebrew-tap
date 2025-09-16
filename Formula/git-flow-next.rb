class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0/git-flow-next-v0.1.0-darwin-amd64.tar.gz"
      sha256 "e4016a372d9fbfaf85171ae8e7c04fe34f9837109bbda7dc4300bedd33503bc3"
      def install
        bin.install "git-flow-v0.1.0-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0/git-flow-next-v0.1.0-darwin-arm64.tar.gz"
      sha256 "53f1f9e9f53562122c65f03dc8ea00cff27f8615f686e579faee74ca4b9b6dcf"
      def install
        bin.install "git-flow-v0.1.0-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0/git-flow-next-v0.1.0-linux-amd64.tar.gz"
      sha256 "27035a56f8780fcae726688d1955fa1eb86f10ba75f5dcf5defd769aa64d9fb4"
      def install
        bin.install "git-flow-v0.1.0-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0/git-flow-next-v0.1.0-linux-arm64.tar.gz"
      sha256 "7e93b70b44f3f5dc8a4840af7d0c0628afed65e5730de13dbeaa99cd5d8de5d5"
      def install
        bin.install "git-flow-v0.1.0-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end