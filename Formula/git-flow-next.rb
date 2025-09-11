class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "0.1.0-rc.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-rc.1/git-flow-next-v0.1.0-rc.1-darwin-amd64.tar.gz"
      sha256 "719ea3f06708d5286c7f371f3dbc5e0eb1592d2b1a1ebf6140522030a38a455c"
      def install
        bin.install "git-flow-v0.1.0-rc.1-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-rc.1/git-flow-next-v0.1.0-rc.1-darwin-arm64.tar.gz"
      sha256 "cd9a5ec4aca8f4a26d4e13e6befabcbe4a9642410f3b17e8bca5c199a372ef12"
      def install
        bin.install "git-flow-v0.1.0-rc.1-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-rc.1/git-flow-next-v0.1.0-rc.1-linux-amd64.tar.gz"
      sha256 "06b75f1932e9e873f1297d61853a7b7de50c9b44cfa990c1980412cf7cad87ee"
      def install
        bin.install "git-flow-v0.1.0-rc.1-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-rc.1/git-flow-next-v0.1.0-rc.1-linux-arm64.tar.gz"
      sha256 "68aa7ae134b4ac7ea1c20d5eca279b58aa221bca292dce96765e209cec7628bf"
      def install
        bin.install "git-flow-v0.1.0-rc.1-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end