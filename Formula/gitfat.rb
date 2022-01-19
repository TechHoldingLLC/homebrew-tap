class Memda < Formula
  VERSION = "v1.0.0".freeze

  # rubocop:disable Layout/HashAlignment
  SUMS = Hash[
    "darwin-amd64"  => "62a991c80f06165e6c52febd2774f17ed775e4a4de6b108b5a8313da2cc06f61",
    "darwin-arm64"  => "b4031470b707548bd8668a38a03df8519afac76c9961bfb8e01fb8764a6539e9",
    "linux-amd64"   => "a84fa326b13994e0865c1d29dd0da975de9f19d7e0c384aa29807be39a65370a",
    "linux-arm64"   => "9bda99da8c40ac4831b28ef5ef2ee077d7bfc6f00f84e2c59c400bb5e22bc811"
  ].freeze
  # rubocop:enable Layout/HashAlignment
  RAW_OS = `uname -s`.freeze
  RAW_ARCH = `uname -m`.freeze

  unless RAW_OS == "Darwin\n" || RAW_OS == "Linux\n"
    raise 'Unsupported OS - please check release page'
  end
  
  unless RAW_ARCH == "x86_64\n" || RAW_ARCH == "arm64\n"
    raise 'Unsupported architecture - please check release page'
  end

  OS = (RAW_OS == "Darwin\n" ? "darwin" : "linux").freeze
  ARCH = (RAW_ARCH == "x86_64\n" ? "amd64" : "arm64").freeze

  SHA256 = SUMS["#{OS}-#{ARCH}"].freeze

  desc "GitHub Repositories Size by Organization"
  homepage "https://labs.techholding.co/gitfat"
  url "https://github.com/TechHoldingLLC/gitfat/releases/download/#{VERSION}/gitfat-#{OS}-#{ARCH}.tar.gz"
  version VERSION
  sha256 SHA256
  license "MPL-2.0"

  def install
    bin.install "gitfat-#{OS}-#{ARCH}" => "gitfat"
  end

  test do
    system "#{bin}/gitfat"
  end
end
