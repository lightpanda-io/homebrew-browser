class Lightpanda < Formula
  desc "Headless browser for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  version "1.0.4"
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
      sha256 "83b0ba5ae31086b675fb3ba50644bda075a13bebabe46dc5f7543952bc41ae46"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-macos"
      sha256 "8c02127c6fc2a713d166349bf1b511d470c8fcd684681927c978cc8bb5952d55"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-aarch64-linux"
      sha256 "f021d49a0b66d07bf2633f8e00870b9075293516f872695b0ca4aeb5848b6ea8"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-linux"
      sha256 "7d22651129901203abdb95c64f49069c49e88f5211f4d8c4c6828c123c4adab4"
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
