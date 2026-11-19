class LaneworkKit < Formula
  desc "lwk: fast file, text, structural and session search for coding agents"
  homepage "https://github.com/lanework-dev/kit"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lanework-dev/kit/releases/download/v0.3.0/lanework-kit-aarch64-apple-darwin.tar.xz"
      sha256 "fb3d31e788f74d8bbe4c81ab2c757c5fbb04f4559630f96ae78937e0750a16b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lanework-dev/kit/releases/download/v0.3.0/lanework-kit-x86_64-apple-darwin.tar.xz"
      sha256 "9a1d323569e30d778628e877eb15e1ebb76578cf54fcd5900898ac6dd1889929"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lanework-dev/kit/releases/download/v0.3.0/lanework-kit-aarch64-unknown-linux-musl.tar.xz"
      sha256 "444f67f3c9d33885fe7155cc388284ae779d8e2f71cd79d45bd7823c302bbcfe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lanework-dev/kit/releases/download/v0.3.0/lanework-kit-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0e531b99dbb423f735618bb0b79551ebb6cad09c3a4b6b7c04afd8b6787918cb"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lwk"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lwk"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lwk"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lwk"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
