class GitFlowNext < Formula
  desc "Next-generation Git Flow tool"
  homepage "https://github.com/gittower/git-flow-next"
  version "0.1.0-rc.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-rc.2/git-flow-next-v0.1.0-rc.2-darwin-amd64.tar.gz"
      sha256 "55440943460f401edc3811b5897c5feac782d43eac68826d39eb976ca1c6a4f4"
      def install
        bin.install "git-flow-v0.1.0-rc.2-darwin-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-rc.2/git-flow-next-v0.1.0-rc.2-darwin-arm64.tar.gz"
      sha256 "f1971613efcd0fa723917e5a728b585cd35c7a4947428fd2917fe08160fd06b1"
      def install
        bin.install "git-flow-v0.1.0-rc.2-darwin-arm64" => "git-flow"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-rc.2/git-flow-next-v0.1.0-rc.2-linux-amd64.tar.gz"
      sha256 "0b9ca2d1aaac729b821f2fe4063e9fef262c8d921b2e0db23aba0da774577137"
      def install
        bin.install "git-flow-v0.1.0-rc.2-linux-amd64" => "git-flow"
      end
    elsif Hardware::CPU.arm?
      url "https://github.com/gittower/git-flow-next/releases/download/v0.1.0-rc.2/git-flow-next-v0.1.0-rc.2-linux-arm64.tar.gz"
      sha256 "32bff0c46472302f6aab8ae7dbe2b55b3b7d5d32ec205a961302aacbe9c314e8"
      def install
        bin.install "git-flow-v0.1.0-rc.2-linux-arm64" => "git-flow"
      end
    end
  end

  test do
    system "#{bin}/git-flow", "--version"
  end
end