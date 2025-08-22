class Ktx < Formula
  desc "Script to switch kubernetes contexts and kubectl versions. Additionally, it can be used to sync your configs with LastPass."
  homepage "https://github.com/peledies/ktx"
  url "https://github.com/peledies/ktx/archive/v0.4.0.tar.gz"
  sha256 "0d8d04d47be70fb0a60f9485f27ece4acd53e702ab99b20f4544ab9ccafbd670"
  version "v0.4.0"

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