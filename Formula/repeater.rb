class Repeater < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeater"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.9/repeater-aarch64-apple-darwin.tar.xz"
      sha256 "92762f2ba9813eddc39e3807723e78e128ba0219b2e0c19de84ec761b7c7237a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.9/repeater-x86_64-apple-darwin.tar.xz"
      sha256 "9b5be8e13bb57fcb06fa0057b4dce2ae59e1681e06f7cda0eab3a58d91fe1f84"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.9/repeater-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "96b6cee12b410bbd21adcb671c3fa0f069b594dd1cfd3dd7ec8cf28aceb7725f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.9/repeater-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6e337a35c65b0c6f42ed00903d5b22bbdb9a9ba50072afcf48c50aa38ded98d"
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
