class Repeat < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeat"
  version "0.0.23"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.23/repeat-aarch64-apple-darwin.tar.xz"
      sha256 "2d58983b0edc62014bb83ceb901f597521ef2baf249896fdbb48c37b819f4ceb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.23/repeat-x86_64-apple-darwin.tar.xz"
      sha256 "6bb17474839279f6e897c061c57b9c42326b34facd980ca6d9ddb7cade669dcb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.23/repeat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b30657f61810ad9da9baede0151a34c21e04fb65c6a46d8c1896b4397114f902"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.23/repeat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "318aec798df7feae433db706cc46c8599c032378498a5995aafda2d3c3e8a29e"
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
