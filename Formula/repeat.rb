class Repeat < Formula
  desc "Your tool description"
  homepage "https://github.com/shaankhosla/repeat"
  url "https://github.com/shaankhosla/repeat/releases/download/v0.0.11/repeat-v0.0.11-aarch64-apple-darwin.tar.gz"
  sha256 "47b28f0d9ffb93f234be0904ff56453540d2e91d1cf1c36f8187c17cbd2ed96b"
  version "0.0.11"

  def install
    bin.install "repeat"
  end
end
