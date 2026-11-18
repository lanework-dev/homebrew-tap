class LaneworkKit < Formula
  desc "lwk: fast file, text, structural and session search for coding agents"
  homepage "https://github.com/lanework-dev/kit"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lanework-dev/kit/releases/download/v0.2.0/lanework-kit-aarch64-apple-darwin.tar.xz"
      sha256 "fd5b5f0efcd185c2d3b6ed5c24a693574109acd5013422f3f2d010a75ec0c4c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lanework-dev/kit/releases/download/v0.2.0/lanework-kit-x86_64-apple-darwin.tar.xz"
      sha256 "37a405fa820f969fce87fcf69343ba192f37c1c488027b20c14ec04d96bf9b96"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lanework-dev/kit/releases/download/v0.2.0/lanework-kit-aarch64-unknown-linux-musl.tar.xz"
      sha256 "00a54e1d9b55ab9861556dcff3b7dded3f138704b7a6b52472143a23ee3006f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lanework-dev/kit/releases/download/v0.2.0/lanework-kit-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a9523274879903ed832724fe30885487f7419eee6916ef90a2a111579c387a68"
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
