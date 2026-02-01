class Repeater < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeater"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.6/repeater-aarch64-apple-darwin.tar.xz"
      sha256 "399fdd14e376eda0c85484989e29aa0e12269ce2b5f5ee3657abf72d958a4abc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.6/repeater-x86_64-apple-darwin.tar.xz"
      sha256 "8a307488910fdc088740ea1cf9e4dd7c9bbc6cb5f6af7485f418683dfe84e1a3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.6/repeater-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "544d2443c5964fc869d51d2e4e14c9169e051d8b7e967635b67e3e4fcc6578ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.6/repeater-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0df6e5c7cbd38e3b5d86f7f25e40796d48951f8eadc0985ce0c63ab4c01f58dd"
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
