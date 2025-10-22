class Ktx < Formula
  desc "Script to switch kubernetes contexts and kubectl versions. Additionally, it can be used to sync your configs with LastPass."
  homepage "https://github.com/peledies/ktx"
  url "https://github.com/peledies/ktx/archive/v0.5.0.tar.gz"
  sha256 "229e9c7d15089f13d1bfdf9417e0d763913ad80a1462ac6910604f3580b2012f"
  version "v0.5.0"

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