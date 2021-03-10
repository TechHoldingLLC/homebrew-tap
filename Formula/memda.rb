class Memda < Formula
  VERSION = "v1.3.0".freeze

  # rubocop:disable Layout/HashAlignment
  SUMS = Hash[
    "darwin-amd64"  => "827ed60e3b2d258c6065dcf29e7dd4ab67e4216636a40e5f2fc40bfaef3faa41",
    "darwin-arm64"  => "ef3b75e713118d46788f31fe6e16e4ba9d6da304b1755ab31e7d8f55f344b34f",
    "linux-amd64"   => "ccb9ef958bd6b51337e0dfb7c3fde0ab889ebd7c4178e7cd20770066ca21dee6"
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
  ARCH = (RAW_OS == "x86_64\n" ? "amd64" : "arm64").freeze

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
