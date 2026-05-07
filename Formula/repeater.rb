class Repeater < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeater"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.10/repeater-aarch64-apple-darwin.tar.xz"
      sha256 "2d8128ffaa4af5599ad405be7585bb27cb4a0851a3766f881778c0c4aac91eab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.10/repeater-x86_64-apple-darwin.tar.xz"
      sha256 "b6c3fa3e9920a5db69b623e32c87bc7b1423a3e8b65e3e7b43aa84ec94cc3077"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.10/repeater-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "77faea8e465e9675cb7ef0e8854caebc7e379fda6751f00164db3c20c13eed6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.10/repeater-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf9e0d0e6873b49349ba585eb98a9a89cc57613b1a70c294ead671ef807bb026"
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
    bin.install "repeater" if OS.mac? && Hardware::CPU.arm?
    bin.install "repeater" if OS.mac? && Hardware::CPU.intel?
    bin.install "repeater" if OS.linux? && Hardware::CPU.arm?
    bin.install "repeater" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
