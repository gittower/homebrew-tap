class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "0.1.0-alpha.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-alpha.2/git-flow-next-v0.1.0-alpha.2-darwin-amd64.tar.gz"
      sha256 "c3a92e587621b8de750f93922e362f085d0d002401ea15ed5fc655f932eaea6b"
      def install
        bin.install "git-flow-v0.1.0-alpha.2-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-alpha.2/git-flow-next-v0.1.0-alpha.2-darwin-arm64.tar.gz"
      sha256 "1d427abb31c8176767624b76059649ac92ac093b77c7b99b563b30b0b2100851"
      def install
        bin.install "git-flow-v0.1.0-alpha.2-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-alpha.2/git-flow-next-v0.1.0-alpha.2-linux-amd64.tar.gz"
      sha256 "038bb58c4e3ec0825a2454d8fcefad5c3eb060001d573fc4ab73238a90968966"
      def install
        bin.install "git-flow-v0.1.0-alpha.2-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-alpha.2/git-flow-next-v0.1.0-alpha.2-linux-arm64.tar.gz"
      sha256 "cd771cb571578ebeb05be346feab86491882757cd4001a61754be0a018a98aa1"
      def install
        bin.install "git-flow-v0.1.0-alpha.2-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end