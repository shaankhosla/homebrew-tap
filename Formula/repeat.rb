class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.8/repeat-darwin-arm64.tar.gz"
  sha256 "505a6924beda0a8cfd11bcaa2f3ee6fcbdf6908d2a58f69fe6577e1dea3ac5d3"
  version "0.0.8"

  def install
    bin.install "repeat"
  end
end
