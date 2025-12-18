class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.6/repeat-darwin-arm64.tar.gz"
  sha256 "0ea40c21c9a8d6c9449b87ee010ec366b90a2cdaf0e36307d4cd34ca46a4993c"
  version "0.0.6"

  def install
    bin.install "repeat"
  end
end
