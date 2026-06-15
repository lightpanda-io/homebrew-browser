class Lightpanda < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026.06.15.034007"

  livecheck do
    url "https://api.github.com/repos/lightpanda-io/browser/releases/tags/nightly"
    strategy :json do |json|
      json["updated_at"]&.slice(0, 10)
    end
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "4261c3e1a13d069100c52fd48c292c1c2e7c3eeda1e96777fefa8d81873036a6"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "c4a40be7ded781796e588cb5898938cbbc3d4b7bcacdc543d9299c25c3bfe05c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "f1bcf4238784b13ae35825ef6f2924728523252b10eac0d4a249965a76f23404"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "1e20a25ad5cac451ab059dfe48eb9fae613acb1c5474693c5b2f26f7697b993b"
    end
  end

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end
