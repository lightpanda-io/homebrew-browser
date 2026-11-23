class LightpandaNightly < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026.11.23.024206"

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
      sha256 "daa528ac0f1afb5d5663f1084c14f4c9494ab4b288a6a9ebbaae1ae138b8b621"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "a9a9edeb07c1cc59e8d41d3ad169d2fa548d003773037705947b521de2016ebb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "a7ad7c290e745b8e37bd1b3e1ac6431caca1482cc30b3c0e485587e10489632a"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "9f6ed6095ea062305ea64be3591279fb22b36ee0f772b395aedda53bf597dae6"
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
