class Repeater < Formula
  desc "Spaced repetition, in your terminal"
  homepage "https://github.com/shaankhosla/repeater"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.1/repeater-aarch64-apple-darwin.tar.xz"
      sha256 "3204e3041657b62a8972cdef8b3daa35ffc32f609470b54f884a4353af13b3ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.1/repeater-x86_64-apple-darwin.tar.xz"
      sha256 "47daa55836984da89a4c5dc527e0b81e60a6c12c2d4b540b13987c13716ec82f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.1/repeater-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "72be00dbf8492cd01edfa87a248ecc5ee9c223c66c58cb066b2c921a480ee69e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shaankhosla/repeater/releases/download/v0.1.1/repeater-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "899e9284815892c86bb7d5dd19ca3ad3bb25394f09438a42071d413bed7c1d05"
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
