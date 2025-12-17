class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.5/repeat-darwin-arm64.tar.gz"
  sha256 "e0191852ce3b037b789af2eabc3c3f9f20a879f679b1fefb1bf2bd6c15be3b91"
  version "0.0.5"

  def install
    bin.install "repeat"
  end
end
