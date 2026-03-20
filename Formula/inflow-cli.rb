class InflowCli < Formula
  include Language::Python::Virtualenv

  desc "CLI tool for InFlow ESP32 hydration sensor devices over BLE"
  homepage "https://github.com/Intake-Health/inflow-cli"
  url "https://github.com/Intake-Health/homebrew-tap/releases/download/v0.2.0/inflow_cli-0.2.0.tar.gz"
  sha256 "90310030cbf92a8bda970341ee236a0b03e10503388d952d1daeb4b634210d9e"
  license "MIT"

  depends_on :macos
  depends_on "python@3.12"

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
    url "https://files.pythonhosted.org/packages/13/89/8808fe75efb03b29e082f9d12da31d55d5be3f55260c7b4e4cde7ebf81af/pyobjc_core-10.3.2-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "16644a92fb9661de841ba6115e5354db06a1d193a5e239046e840013c7b3874d"
  end

  resource "pyobjc-framework-Cocoa" do
    url "https://files.pythonhosted.org/packages/22/fc/496c6ce1386f93d22d9a1ee1889215ed69989d976efa27e46b37b95a4f2d/pyobjc_framework_Cocoa-10.3.2-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "c49e99fc4b9e613fb308651b99d52a8a9ae9916c8ef27aa2f5d585b6678a59bf"
  end

  resource "pyobjc-framework-CoreBluetooth" do
    url "https://files.pythonhosted.org/packages/f7/b0/9006d9d6cc5780fc190629ff42d8825fe7737dbe2077fbaae38813f0242e/pyobjc_framework_CoreBluetooth-10.3.2-cp36-abi3-macosx_10_13_universal2.whl"
    sha256 "973b78f47c7e2209a475e60bcc7d1b4a87be6645d39b4e8290ee82640e1cc364"
  end

  resource "pyobjc-framework-libdispatch" do
    url "https://files.pythonhosted.org/packages/e0/e9/8e364765ccb1f3c686d922e2512499f2b4e25bfbfa5d73e833478bff88b5/pyobjc_framework_libdispatch-10.3.2-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "6bb528f34538f35e1b79d839dbfc398dd426990e190d9301fe2d811fddc3da62"
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

      OTA firmware updates require an additional dependency:
        pip install pyobjc-framework-IOBluetooth
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/inflow --help")
  end
end
