class LightpandaNightly < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026.11.21.024346"

  livecheck do
    url "https://api.github.com/repos/lightpanda-io/browser/releases/tags/nightly"
    strategy :json do |json|
      # Same format as the version: 2026-10-14T08:22:54Z -> 2026.10.14.082254
      json["updated_at"]&.delete(":Z")&.tr("-T", "..")
    end
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "9307c5290fd02acf5af31ea3cf18295df857c63d2a3ed3520173eebafac7b192"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "7c0dd7ff9f2a7e5e4c26bf61a456f5e7e013307da0391a44280b346050bddd98"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "9c49ed4c349f8ef2c3ca2af156b75e51bda6939ba3f04380c64c4efeac5303f6"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "66934fac032e9a0ad246fa8d45a57ef1cc81570630e77cb6af9b3377f3b76cd1"
    end
  end

  conflicts_with "lightpanda", because: "both install a `lightpanda` binary"

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end
