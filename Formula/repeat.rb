class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.7/repeat-darwin-arm64.tar.gz"
  sha256 "3a34bcd2741c4dd73d806b8c7494967685f418f0799c7430014f857e26fa2944"
  version "0.0.7"

  def install
    bin.install "repeat"
  end
end
