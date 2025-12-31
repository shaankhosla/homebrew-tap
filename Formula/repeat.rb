class Repeat < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeat"
  version "0.0.22"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.22/repeat-aarch64-apple-darwin.tar.xz"
      sha256 "33a8966a3d202e6956ad7841d8fb1a711da8ac016a5b6f54b1c8a7279868930c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.22/repeat-x86_64-apple-darwin.tar.xz"
      sha256 "bf1dde29ce5c4f1dd51704952f19d61f2d90328748d84249ba1f779c65fa6214"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.22/repeat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "176c1ca1e1eebc054de892b869e4e44c72339eef75f21b3e0dfe581f6e1cd5a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.22/repeat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e33135522d1721db7f4d9b8bea4c94941c1c311f125b74fb9d7ea20dba944e1f"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "repeat" if OS.mac? && Hardware::CPU.arm?
    bin.install "repeat" if OS.mac? && Hardware::CPU.intel?
    bin.install "repeat" if OS.linux? && Hardware::CPU.arm?
    bin.install "repeat" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
