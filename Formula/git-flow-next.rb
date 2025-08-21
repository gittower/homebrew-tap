class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "0.1.0-alpha.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-alpha.1/git-flow-next-v0.1.0-alpha.1-darwin-amd64.tar.gz"
      sha256 "85cea451eec057fa7e734548ca3ba6d779ed5836a3f9de14b8394575ef0d7d8e"
      def install
        bin.install "git-flow-next-v0.1.0-alpha.1-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-alpha.1/git-flow-next-v0.1.0-alpha.1-darwin-arm64.tar.gz"
      sha256 "85cea451eec057fa7e734548ca3ba6d779ed5836a3f9de14b8394575ef0d7d8e"
      def install
        bin.install "git-flow-next-v0.1.0-alpha.1-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-alpha.1/git-flow-next-v0.1.0-alpha.1-linux-amd64.tar.gz"
      sha256 "85cea451eec057fa7e734548ca3ba6d779ed5836a3f9de14b8394575ef0d7d8e"
      def install
        bin.install "git-flow-next-v0.1.0-alpha.1-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-alpha.1/git-flow-next-v0.1.0-alpha.1-linux-arm64.tar.gz"
      sha256 "85cea451eec057fa7e734548ca3ba6d779ed5836a3f9de14b8394575ef0d7d8e"
      def install
        bin.install "git-flow-next-v0.1.0-alpha.1-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end