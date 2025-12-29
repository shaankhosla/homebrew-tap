class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.13/repeat-v0.0.13-aarch64-apple-darwin.tar.gz"
  sha256 "fb4317d70328377973be482a2e333317013a9a08c0dff714dc94207a27dd77c8"
  version "0.0.13"

  def install
    bin.install "repeat"
  end
end
