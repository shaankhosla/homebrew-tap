class Repeat < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeat"
  version "0.0.24"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.24/repeat-aarch64-apple-darwin.tar.xz"
      sha256 "2071ab8e04f113498e25ef591e5fa1469c848ddd7d46677277d8a82556bf39d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.24/repeat-x86_64-apple-darwin.tar.xz"
      sha256 "c8b8f8111e19ac8bbedb5c01a27cb9dc5e7ad222a70391441bc1a52e9ae62003"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.24/repeat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b7244d986194ab233d216ad8dc03527a6182b841d4909fe0dba90f41e98e758d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeat/releases/download/v0.0.24/repeat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4726fafc9a9fddd817055d9e7ae217fdb50fd37cf540112a391de18a74fb054c"
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
