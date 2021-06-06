class Sectionctl < Formula
  desc "Section Command-line Tools"
  homepage "https://github.com/section/sectionctl"
  url "https://github.com/section/sectionctl/archive/refs/tags/v1.11.1.tar.gz"
  sha256 "5d3b47ea1b2641aa312e13a8bd282cb3aeb7caa540585e8f600dd621a3b1bfda"
  license "MIT"

  bottle do
    root_url "https://github.com/section/homebrew-brews/releases/download/sectionctl-1.11.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:     "4584c4ca6c5d16d8ec8c4b21e1b739b99f9a3cd65c2e33f88acd60122b98fce8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8458a4a2d15729f8cb2010687d7fdbcd8adb11bd4edc1ad4f5c4b28e908759d9"
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
