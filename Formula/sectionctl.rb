class Sectionctl < Formula
  desc "Section Command-line Tools"
  homepage "https://github.com/section/sectionctl"
  url "https://github.com/section/sectionctl/archive/refs/tags/v1.12.1.tar.gz"
  sha256 "8a8f8d06e9d9bec5b48efceaf0292e674e1951ab07b0e67797fdfebf5e76e62b"
  license "MIT"

  bottle do
    root_url "https://github.com/section/homebrew-brews/releases/download/sectionctl-1.12.0"
    sha256 cellar: :any_skip_relocation, catalina:     "cc7f5c4595505d515fbb1e4bcc5ea56a2baf4d19ae98c4f705d02218fe8ea3ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "22e8dae4a3458a1f6a22d5f26131e0500100f3808e2ae28b41819389ca6ffc04"
  end

  depends_on "go" => :build

  def install
    # extract goos and goarch to figure out which platform the machine is on
    goos = `go env GOOS`.strip
    goarch = `go env GOARCH`.strip
    ENV["VERSION"] = "v#{version}"
    # run make build-release with the goos and goarch extracted from go
    system "make", "build-release", "GOOS=#{goos}", "GOARCH=#{goarch}"
    bin.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/sectionctl"
    prefix.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/LICENSE"
    prefix.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/README.md"
  end

  test do
    system "#{bin}/sectionctl", "--help"
  end
end
