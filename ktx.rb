class Ktx < Formula
  desc "Script to switch kubernetes contexts and kubectl versions. Additionally, it can be used to sync your configs with LastPass."
  homepage "https://github.com/peledies/ktx"
  url "https://github.com/peledies/ktx/archive/v0.5.1.tar.gz"
  sha256 "9c5395f23759d67dda75c3e23da6fa54458f4e16b84bc9230dacfbd5140e00ce"
  version "v0.5.1"

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