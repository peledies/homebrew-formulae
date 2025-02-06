class Ktx < Formula
  desc "Script to switch kubernetes contexts and kubectl versions. Additionally, it can be used to sync your configs with LastPass."
  homepage "https://github.com/peledies/ktx"
  url "https://github.com/peledies/ktx/archive/v0.2.tar.gz"
  sha256 "6c5b132f69c777317d2dc508d5f23d7e581897dafe02fd35b28234b76667bca8"
  version "v0.2"

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