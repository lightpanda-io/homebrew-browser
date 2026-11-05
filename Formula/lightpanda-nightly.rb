class LightpandaNightly < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026.11.05.062816"

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
      sha256 "8588eb378ab59fb9f7c3a74b031c256f9911874007fda71fc70c06cca25d0660"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "40c16f400cdfed90eff7dd7f08e4dbd4c3a0cad72159536f2b0d684fdca4fab1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "8e30fcf82f6f0d8153c6450bfc1512924e5785f29d0fc0a626b42451e16b1393"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "12c2fa17689398d2fd6733e3b30b95ae8359fe3f805032a09967d1fc8c9c6633"
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
