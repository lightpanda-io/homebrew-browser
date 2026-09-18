class Lightpanda < Formula
  desc "Headless browser for AI agents and automation (nightly build)"
  homepage "https://github.com/lightpanda-io/browser"
  version "2026.09.18.025154"

  livecheck do
    url "https://api.github.com/repos/lightpanda-io/browser/releases/tags/nightly"
    strategy :json do |json|
      json["updated_at"]&.slice(0, 10)
    end
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
      sha256 "33c574f5e7936a8f47cf220a5dc0c7acf9fb2f007367456d17b7dc3e8888a65b"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-macos"
      sha256 "a07d19cf980d5d67a4fe1888d9f205c79836f12b7fb3c6b0fc8e3d30464e058f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-linux"
      sha256 "17285df667851ed2e118ad18da238a8ae57c116bc0c1f7a261411c50b5943516"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux"
      sha256 "c2fb4f284bbdf8eaa41f084a91e9eab8b5a39decf781302d6c6ea28f57dc9d7a"
    end
  end

  def install
    bin.install Dir["lightpanda-*"].first => "lightpanda"
  end

  test do
    shell_output("#{bin}/lightpanda version 2>&1")
  end
end
