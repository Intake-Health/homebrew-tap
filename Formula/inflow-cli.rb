class InflowCli < Formula
  include Language::Python::Virtualenv

  desc "CLI tool for InFlow ESP32 hydration sensor devices over BLE"
  homepage "https://github.com/Intake-Health/inflow-cli"
  url "https://github.com/Intake-Health/inflow-cli/releases/download/v0.1.0/inflow_cli-0.1.0.tar.gz",
      using: :github_private_release
  sha256 "4a230010e9b04cb949d24c3e0f282cb5303ad67989d7284d510ca54258192747"
  license "MIT"

  depends_on "python@3.12"

  # Dependencies — regenerate with:
  #   pip install homebrew-pypi-poet
  #   pip install inflow-cli
  #   poet inflow-cli

  resource "bleak" do
    url "https://files.pythonhosted.org/packages/source/b/bleak/bleak-0.22.3.tar.gz"
    sha256 "3149c3c19657e457727aa53d9d6aeb89658495822cd240afd8aeca4dd09c045c"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/source/t/typer/typer-0.9.4.tar.gz"
    sha256 "f714c2d90afae3a7929fcd72a3abb08df305e1ff61719381384211c4070af57f"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/source/r/rich/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage", shell_output("#{bin}/inflow --help")
  end
end
