class Repeater < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeater"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.2/repeater-aarch64-apple-darwin.tar.xz"
      sha256 "c0c3c9619ff2597a333ede473489153ac76e7b9eafb35f94087685d414234b58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.2/repeater-x86_64-apple-darwin.tar.xz"
      sha256 "f701165205f0745fd439e0bb3c10189b49cfe69f1d199774c8a1d40c39c82227"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.2/repeater-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c1da902d44521969211b9915c45381d7c6b36017369bfed3181ed4e31f7b7417"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.2/repeater-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b11773b0bd549d9ce7cf3c96194c8d5a887966b2b28fcf5a254026bfc443989a"
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
