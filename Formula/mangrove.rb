class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/mangrove"
  url "https://github.com/swamp/mangrove/releases/download/v0.0.15/mangrove-darwin-x86_64.tar.gz"
  version "0.0.15"
  sha256 "6fcf12cfafaa84657fb9485728c239c60d9965ca515eecfb1c8be58c31659421"

  resource "packages" do
    url "https://github.com/swamp/mangrove/releases/download/v0.0.15/packages.tar.gz"
    sha256 "d6e2d55264bf5d3873a4c918a84071308d9ca854ca1ee1f4922f1eebee27eae9"
  end


  def install
    prefix.install Dir["mangrove/*"]
    system "xattr", "-cr", prefix
    bin.install "mangrove" => "mangrove"

    resource("packages").stage do
      pkgshare.install Dir["*"]
    end
  end

  def caveats
    s = <<~EOS
      mangrove has been installed to:
        #{prefix}

      Mangrove has installed its additional packages into:
        #{pkgshare}/packages

      By default, Mangrove expects its packages to be located in ~/.swamp/packages.
      To ensure Mangrove can find these files, you have two options:

        1. Update the SWAMP_HOME environment variable:
           export SWAMP_HOME="#{pkgshare}"

        2. Copy the packages to your home directory:
           mkdir -p ~/.swamp/packages
           cp -R #{pkgshare}/packages/* ~/.swamp/packages/

      Choose the option that works best for your workflow.

      Executable is available as: `mangrove`
    EOS
    s
  end
end