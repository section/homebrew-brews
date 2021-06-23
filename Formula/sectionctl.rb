class Sectionctl < Formula
  desc "Section Command-line Tools"
  homepage "https://github.com/section/sectionctl"
  url "https://github.com/section/sectionctl/archive/refs/tags/v1.12.2.tar.gz"
  sha256 "9aeff2ae55c21e1830a82cfb8856d1e4b860309de303461ab68c0e4052ee0899"
  license "MIT"

  bottle do
    root_url "https://github.com/section/homebrew-brews/releases/download/sectionctl-1.12.2"
    sha256 cellar: :any_skip_relocation, catalina:     "66da173328d1d48e18e3d64fc3d73cb545fa082016661987768c69c1e1286668"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "968668f398f9b5f48e760c6d41110f80ca0c2bc1069a898a522721fc626a1720"
  end

  depends_on "go" => :build

  def install
    # extract goos and goarch to figure out which platform the machine is on
    goos = `go env GOOS`.strip
    goarch = `go env GOARCH`.strip
    ENV["VERSION"] = "v#{version}"
    # run make build-release with the goos and goarch extracted from go
    # 
    system "make", "build-release", "GOOS=#{goos}", "GOARCH=#{goarch}"
    bin.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/sectionctl"
    prefix.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/LICENSE"
    prefix.install "dist/sectionctl-v#{version}-#{goos}-#{goarch}/README.md"
  end

  test do
    system "#{bin}/sectionctl", "--help"
  end
end
