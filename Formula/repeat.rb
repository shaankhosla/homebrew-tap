class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.12/repeat-v0.0.12-aarch64-apple-darwin.tar.gz"
  sha256 "1a7a7ff8f2fae53e6740acba8d749bc8d1861de7417c96a3c84c59233846a2bb"
  version "0.0.12"

  def install
    bin.install "repeat"
  end
end
