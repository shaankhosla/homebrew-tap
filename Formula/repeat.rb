class Repeat < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeat"
  version "0.0.21"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.21/repeat-aarch64-apple-darwin.tar.xz"
      sha256 "f04cee5bb290075e94b36abab387905786db19d5f971ce46a64283751c630b5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.21/repeat-x86_64-apple-darwin.tar.xz"
      sha256 "a8dfeb685a50ff89180dc49999080b3b7b1d25dbf01450bdec10671338ff232e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.21/repeat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4ef7387f0c0c2d6f1b967c0e88c92f2e73d5d8dfa2dc7075f3fdf40147390bf0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.21/repeat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "61d16c0af1cccb245cba59be0cea2a2cb6a0919f2b1fc71e9b2225b3ca7f7643"
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
