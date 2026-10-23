class Lightpanda < Formula
  desc "Headless browser for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  version "1.0.2"
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
      sha256 "9f3ee749a55d1abc5f8fdda0d9559c3b2abcec5bff5bfe902bc06c0a89538ec4"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-macos"
      sha256 "91a775ecc67937d8d79c1b1a315748e52157804f18f629c6e1c6332a46255fc6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-aarch64-linux"
      sha256 "ac546dfc43c533430da92b75ab36f2a29da7d6324d5d38baf606ef2e0d849345"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-linux"
      sha256 "ae7d01d261efb9e480e18ce3424533332883863bcf70b12a4321b5733f37e19e"
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
