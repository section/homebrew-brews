class Sectionctl < Formula
  version "1.11.1"
  desc "sectionctl Commandline Tools"
  homepage "https://github.com/section/sectionctl"
  url "https://github.com/section/sectionctl/archive/refs/tags/v#{version}.tar.gz"
  sha256 "5d3b47ea1b2641aa312e13a8bd282cb3aeb7caa540585e8f600dd621a3b1bfda"
  license "MIT"

  depends_on "go" => :build

  def install
    goos = `go env GOOS`.strip
    goarch = `go env GOARCH`.strip
    ENV["VERSION"] = "v#{version}"
    system "make", "build-release", "GOOS=#{goos}", "GOARCH=#{goarch}"
    bin.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/sectionctl"
    prefix.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/LICENSE"
    prefix.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/README.md"
  end

  test do
    system "#{bin}/sectionctl", "--help"
  end
end
