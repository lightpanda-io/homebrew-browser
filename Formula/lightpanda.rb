class Lightpanda < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026.09.15.024919"

  livecheck do
    url "https://api.github.com/repos/lightpanda-io/browser/releases/tags/nightly"
    strategy :json do |json|
      json["updated_at"]&.slice(0, 10)
    end
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "35fee8376e8e71e70bce615382efbc228176e22a3e3cfabfd0eb0fb6264ce96d"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "8b2c5e5c88b816c8476f2276aa11611a7206f3615b3d8170f461746f3f4de22f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "747813532b7993a20559c55a15b770e07d987ddeeb81c85057404b4efaa0a143"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "a036f12ce955c2388d38c99c5e688a06a96642c593d49e00db984862fb9b41cf"
    end
  end

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end
