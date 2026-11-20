class Lightpanda < Formula
  desc "Headless browser for AI agents and automation"
  homepage "https://github.com/lightpanda-io/browser"
  version "1.0.5"
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
      sha256 "eec3781086ee512320a04b036f092806a8a959944ea78fc8f4fe7dfe215a84b4"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-macos"
      sha256 "2b75c9fee5c36d5d840f7938df6a532074bec03bf0485c3130b28597999a66fe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-aarch64-linux"
      sha256 "7527391c479f323eb9111b834b012d91a89057528c28ef027741b21739b12299"
    else
      url "https://github.com/lightpanda-io/browser/releases/download/#{version}/lightpanda-x86_64-linux"
      sha256 "0ec21fa4867ab9e82b35285ff4ab0e7336c6c1d89f26fe991f27d73c8a678bd7"
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
