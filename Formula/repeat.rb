class Repeat < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeat"
  version "0.0.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.17/repeat-aarch64-apple-darwin.tar.xz"
      sha256 "d7b0df9abff648c72ee3f0153f8c56918616a1310fe1bd6d195fcbe50639ad4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.17/repeat-x86_64-apple-darwin.tar.xz"
      sha256 "4e0a4f47900acca12a52ff6c619525d7adb36758d6359947f55aeedfcb3125ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.17/repeat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7b754b2acd71de42c06cf61a2b0c4644c1a0d27617ab30efc44ad5bf176753fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.17/repeat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ab99c53380664c0fc2da91058106dbdbcfc1dc8f4ad9d382829f634b34a57303"
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
