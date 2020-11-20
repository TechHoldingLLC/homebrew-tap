class Memda < Formula
  VERSION = "v1.2.0".freeze

  # rubocop:disable Layout/HashAlignment
  SUMS = Hash[
    "darwin-amd64"  => "cf8ef4f5343fb3a878b16ce7b444ee8dccea49f7c1a2b5f9ad1e507552fffe2d",
    "linux-amd64"   => "62a681f53b031bc20a6319575595e754b6d84a8c12154763cd159f72c712eec3"
  ].freeze
  # rubocop:enable Layout/HashAlignment
  RAW_OS = `uname -s`.freeze
  RAW_ARCH = `uname -m`.freeze

  unless RAW_OS == "Darwin\n" || RAW_OS == "Linux\n"
    raise 'Unsupported OS - please check release page'
  end
  
  unless RAW_ARCH == "x86_64\n"
    raise 'Unsupported architecture - please check release page'
  end

  OS = (RAW_OS == "Darwin\n" ? "darwin" : "linux").freeze
  ARCH = "amd64".freeze

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
