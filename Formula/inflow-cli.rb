class InflowCli < Formula
  include Language::Python::Virtualenv

  desc "CLI tool for InFlow ESP32 hydration sensor devices over BLE"
  homepage "https://github.com/Intake-Health/inflow-cli"
  url "https://github.com/Intake-Health/homebrew-tap/releases/download/v0.2.0/inflow_cli-0.2.0.tar.gz"
  sha256 "90310030cbf92a8bda970341ee236a0b03e10503388d952d1daeb4b634210d9e"
  license "MIT"

  depends_on :macos
  depends_on "python@3.12"

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
    venv = virtualenv_create(libexec, "python3.12")

    # Install pyobjc packages from PyPI directly — pip will use pre-built
    # wheels, avoiding the source build that fails without pkg_resources.
    # These are required by bleak for macOS CoreBluetooth access.
    venv.pip_install "pyobjc-core==10.3.2"
    venv.pip_install "pyobjc-framework-Cocoa==10.3.2"
    venv.pip_install "pyobjc-framework-CoreBluetooth==10.3.2"
    venv.pip_install "pyobjc-framework-libdispatch==10.3.2"

    # Install bleak from PyPI (its other deps are already satisfied above)
    venv.pip_install "bleak==0.22.3"

    # Install remaining pure-Python resources from formula
    venv.pip_install resources
    venv.pip_install_and_link buildpath
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

      OTA firmware updates require an additional dependency:
        pip install pyobjc-framework-IOBluetooth
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/inflow --help")
  end
end
