class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.9/repeat-darwin-arm64.tar.gz"
  sha256 "6277902462654622920852cf688bc5b6ccbd51bdc01a284c83da3cb758303b07"
  version "0.0.9"

  def install
    bin.install "repeat"
  end
end
