class OuLogin < Formula
  desc "Log in to OpenUnison Kubernetes clusters and rename the kubeconfig context"
  homepage "https://github.com/peledies/ou-login"
  url "https://github.com/peledies/ou-login/archive/v0.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  version "v0.1.0"

  depends_on "fzf"
  depends_on "yq"

  def install
    bin.install "ou-login" => "ou-login"
  end

  def caveats
    <<~EOS
      ou-login requires kubectl with the openunison-cli plugin.
      Hosts are configured in ~/.config/openunison-config.yaml:

        hosts:
          - hostname: k8sou.example.com
            kubeconfig: ~/.kube/config-example
            context: example   # optional

      Usage:
      - ou-login: pick a host with fzf and log in.
      - ou-login <hostname>: log in to that host.
    EOS
  end

  test do
    assert_match "ou-login", shell_output("#{bin}/ou-login --version")
  end
end
