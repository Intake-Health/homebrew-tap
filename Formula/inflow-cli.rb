class InflowCli < Formula
  include Language::Python::Virtualenv

  desc "CLI tool for InFlow ESP32 hydration sensor devices over BLE"
  homepage "https://github.com/Intake-Health/inflow-cli"
  url "https://github.com/Intake-Health/homebrew-tap/releases/download/v0.2.0/inflow_cli-0.2.0.tar.gz"
  sha256 "90310030cbf92a8bda970341ee236a0b03e10503388d952d1daeb4b634210d9e"
  license "MIT"

  depends_on "python@3.12"

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/source/s/setuptools/setuptools-75.8.2.tar.gz"
    sha256 "4880473a969e5f23f2a2be3646b2dfd84af9028716d398e46192f84bc36900d2"
  end

  resource "bleak" do
    url "https://files.pythonhosted.org/packages/source/b/bleak/bleak-0.22.3.tar.gz"
    sha256 "3149c3c19657e457727aa53d9d6aeb89658495822cd240afd8aeca4dd09c045c"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/source/c/click/click-8.1.8.tar.gz"
    sha256 "ed53c9d8990d83c2a27deae68e4ee337473f6330c040a31d4225c9574d16096a"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/source/m/markdown-it-py/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/source/m/mdurl/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/source/p/pygments/pygments-2.18.0.tar.gz"
    sha256 "786ff802f32e91311bff3889f6e9a86e81505fe99f2735bb6d60ae0c5004f199"
  end

  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/packages/source/p/pyobjc-core/pyobjc_core-10.3.2.tar.gz"
    sha256 "dbf1475d864ce594288ce03e94e3a98dc7f0e4639971eb1e312bdf6661c21e0e"
  end

  resource "pyobjc-framework-CoreBluetooth" do
    url "https://files.pythonhosted.org/packages/source/p/pyobjc-framework-corebluetooth/pyobjc_framework_corebluetooth-10.3.2.tar.gz"
    sha256 "c0a077bc3a2466271efa382c1e024630bc43cc6f9ab8f3f97431ad08b1ad52bb"
  end

  resource "pyobjc-framework-libdispatch" do
    url "https://files.pythonhosted.org/packages/source/p/pyobjc-framework-libdispatch/pyobjc_framework_libdispatch-10.3.2.tar.gz"
    sha256 "e9f4311fbf8df602852557a98d2a64f37a9d363acf4d75634120251bbc7b7304"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/source/r/rich/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/source/t/typer/typer-0.9.4.tar.gz"
    sha256 "f714c2d90afae3a7929fcd72a3abb08df305e1ff61719381384211c4070af57f"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/source/t/typing_extensions/typing_extensions-4.12.2.tar.gz"
    sha256 "1a7ead55c7e559dd4dee8856e3a88b41225abfe1ce8df57b7c13915fe121ffb8"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Usage:
        inflow scan                          Discover nearby InFlow devices
        inflow read <device>                 Read all device characteristics
        inflow test <device>                 Trigger a test and display results
        inflow baseline <device>             Trigger a factory baseline capture
        inflow config <device> [OPTIONS]     Read or write device configuration
        inflow wifi <device> [OPTIONS]       Read or write WiFi settings
        inflow ota <device> <firmware.bin>   OTA firmware update

      Run `inflow --help` for full details.

      Note: InFlow devices only advertise BLE while on the charger.
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/inflow --help")
  end
end
