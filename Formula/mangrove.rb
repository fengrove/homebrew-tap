class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/fengrove"
  url "https://github.com/fengrove/fengrove/releases/download/v0.0.32/mangrove-darwin-x86_64.tar.gz"
  version "0.0.32"
  sha256 "5934a54c7395b20cc6cbaf2670b4b891fe74c05b3a6ecdae9364d38886069cb5"

  resource "packages" do
    url "https://github.com/fengrove/fengrove/releases/download/v0.0.32/packages.tar.gz"
    sha256 "c2d25bc5a2085dc298a39b3942c9bd8558846f90f2dbb7e3f506e3cb35e5f7d5"
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

        a. Update the SWAMP_HOME environment variable:

            export SWAMP_HOME="#{opt_pkgshare}"

            You probably want to add this to your shell configuration file (~/.zshrc):

                export SWAMP_HOME="$(brew --prefix mangrove)/share/mangrove"

                or do it automatically:

                echo 'export SWAMP_HOME="$(brew --prefix mangrove)/share/mangrove"' >> ~/.zshrc

        b. Symlink the packages
           ln -s #{opt_pkgshare} ~/.swamp

      Choose the option that works best for your workflow.

      Executable is available as: `mangrove`
    EOS
    s
  end
end