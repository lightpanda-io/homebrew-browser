class LightpandaNightly < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026.10.19.025850"

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
      sha256 "6d225fc2a7206303e81722de4f5e28e3ada4babf62c9331de409378149b6cd18"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "96ccec4b57b6b191af1c46e39013d06a09169a5dfffd33502c8606ee02326cb3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "33d8b7447b39fb993e89f318ed5efe4d743f2324096878b10c554f0e6727da5b"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "c17ffa9836f1e99b77e87cb3094964917dab274080f6a0c004ca7c63f23d7cd1"
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
