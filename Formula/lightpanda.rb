class Lightpanda < Formula
  desc "Headless browser for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  version "1.0.0"
  # Older versions of this formula used nightly dates (e.g. 2026.10.14) as version.
  # The scheme bump makes tagged versions newer than those dates.
  version_scheme 1

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-aarch64-macos"
      sha256 "955440053a84754dd64c62f970449a56a2b350cdf43ea5f2e809a73047b8173d"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-macos"
      sha256 "e510299683b37a203912eac0ee00732224b2ef9b07fe58e69c467f5255be45e2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-aarch64-linux"
      sha256 "69791924bcee43b13b224af4c845622c5fe66fdbc1b8143bfaa39ca8f85244f5"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-linux"
      sha256 "aa5a4b8ed53d1e38b3c73f5b2647d0a84a82e6744557f45f9a9c85858aa031c3"
    end
  end

  conflicts_with "lightpanda-nightly", because: "both install a `lightpanda` binary"

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end
