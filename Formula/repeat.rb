class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.10/repeat-v0.0.10-aarch64-apple-darwin.tar.gz"
  sha256 "9eb9d43e8927997b2243ef075561a60d19930e4c5e99e2b84ac3e092ef69cadc"
  version "0.0.10"

  def install
    bin.install "repeat"
  end
end
