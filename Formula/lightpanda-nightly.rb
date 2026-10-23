class LightpandaNightly < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026.10.23.025503"

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
      sha256 "04cb17a31db274d581938c4011ab438156baacb8357d994149f117a76b4177d5"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "902b171cd91e18af817c044c7e6b00dbbc88572a927e0f29db867fc63dc8a6a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "7480f41254b0bd3ffd43d307c09e0ac0dea811ec4bd9b40323589d73154b8441"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "8ded2143fd17eeda069e4d789030b12038d91523ae0950ecf395c1a67eefe738"
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
