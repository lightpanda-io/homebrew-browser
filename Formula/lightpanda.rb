class Lightpanda < Formula
  desc "Headless browser for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  version "1.0.6"
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
      sha256 "1a27a8692bc0e3821fbcbd5108608ef5233d2d64097ff0cf7837d1be9fe3f03b"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-macos"
      sha256 "d2bb233b444a075057cd48a1da88d45c640e292a9de85ceff026793b091e126d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-aarch64-linux"
      sha256 "26e0042a52f493d8cc1b04faef42aea9b46bef9ccfcc86170098bd330c19a890"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-linux"
      sha256 "a9bff4c0b8498433cd16d8165a5e5b47181e5690d4c8e1f011d601f1f2e8a467"
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
