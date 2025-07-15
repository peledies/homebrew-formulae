class Ktx < Formula
  desc "Script to switch kubernetes contexts and kubectl versions. Additionally, it can be used to sync your configs with LastPass."
  homepage "https://github.com/peledies/ktx"
  url "https://github.com/peledies/ktx/archive/v0.3.0.tar.gz"
  sha256 "99fe214d603aa0940309f68cd1491f26133feff5ca0c71abc6e18d33a341beb8"
  version "v0.3.0"

  def install
    bin.install "ktx" => "ktx"
  end

  def caveats
    <<~EOS
      This script requires the lastpass cli to use the config sync feature.
      Usage:
      - ktx: List all available contexts and switch to the selected one.
    EOS
  end
end