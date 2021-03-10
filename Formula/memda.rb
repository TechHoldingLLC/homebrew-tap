class Memda < Formula
  VERSION = "v1.3.1".freeze

  # rubocop:disable Layout/HashAlignment
  SUMS = Hash[
    "darwin-amd64"  => "0027994f0d393436475e0ef5d7bd8d66482e648765189160f57511543089c9a1",
    "darwin-arm64"  => "02345dadee486f272bd0b659662432ad1d66330b4c236e6ed9071bacda3a5a84",
    "linux-amd64"   => "875a350871d0242c2cd261ea67a2dfcacc1fc0df22cdf17b8d58477651e32573"
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

  desc "AWS Lambda Memory Usage Checker"
  homepage "https://labs.techholding.co/memda"
  url "https://github.com/TechHoldingLLC/memda/releases/download/#{VERSION}/memda-#{OS}-#{ARCH}.tar.gz"
  version VERSION
  sha256 SHA256
  license "MPL-2.0"

  def install
    bin.install "memda-#{OS}-#{ARCH}" => "memda"
  end

  test do
    system "#{bin}/memda"
  end
end
