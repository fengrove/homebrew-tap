class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/mangrove"
  url "https://github.com/swamp/mangrove/releases/download/v0.0.18/mangrove-darwin-x86_64.tar.gz"
  version "0.0.18"
  sha256 "9bde37f6ec82c73bde29ab5f54fbc48feef9099bc85a5be97a930b89b6523322"

  resource "packages" do
    url "https://github.com/swamp/mangrove/releases/download/v0.0.18/packages.tar.gz"
    sha256 "44fa57e51f4d9613140ad794595595bc04cf133e27ca08008e676631c79e3a88"
  end

  def install
    prefix.install Dir["mangrove/*"]
    system "xattr", "-cr", prefix

    bin.install "mangrove" => "mangrove"

    resource("packages").stage do
      (pkgshare/"packages").install Dir["*"]
    end
  end

  def caveats
    s = <<~EOS
      mangrove has been installed to:
        #{prefix}

      Mangrove has installed its additional packages into:
        #{opt_pkgshare}/packages

      By default, Mangrove expects its packages to be located in ~/.swamp/packages.
      To ensure Mangrove can find these files, you have two options:

        1. Update the SWAMP_HOME environment variable:
           export SWAMP_HOME="#{opt_pkgshare}"

        2. Copy the packages to your home directory:
           mkdir -p ~/.swamp/packages
           cp -R #{opt_pkgshare}/packages/* ~/.swamp/packages/

      Choose the option that works best for your workflow.

      Executable is available as: `mangrove`
    EOS
    s
  end
end