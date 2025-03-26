class Mangrove < Formula
  desc "Fengrove (Unsigned)"
  homepage "https://github.com/fengrove"
  url "https://github.com/fengrove/fengrove/releases/download/v0.0.23/mangrove-darwin-x86_64.tar.gz"
  version "0.0.23"
  sha256 "a933e664ee436eef3fac904123ae3b43b1f447b6726be15c5ab9a7d86624b10e"

  resource "packages" do
    url "https://github.com/fengrove/fengrove/releases/download/v0.0.23/packages.tar.gz"
    sha256 "ba7312815290d86e1c3524ccd9957c096a4fdbd94efea5f9ee933cf21e5693d7"
  end

  def install
    prefix.install Dir["fengrove/*"]
    system "xattr", "-cr", prefix

    bin.install "fengrove" => "fengrove"

    resource("packages").stage do
      (pkgshare/"packages").install Dir["*"]
    end
  end

  def caveats
    s = <<~EOS
      Fengrove has been installed to:
        #{prefix}

      Fengrove has installed its additional packages into:
        #{opt_pkgshare}/packages

      By default, Fengrove expects its packages to be located in ~/.swamp/packages.
      To ensure Fengrove can find these files, you have two options:

        a. Update the SWAMP_HOME environment variable:

            export SWAMP_HOME="#{opt_pkgshare}"

            You probably want to add this to your shell configuration file (~/.zshrc):

                export SWAMP_HOME="$(brew --prefix fengrove)/share/fengrove"

                or do it automatically:

                echo 'export SWAMP_HOME="$(brew --prefix fengrove)/share/fengrove"' >> ~/.zshrc

        b. Symlink the packages
           ln -s #{opt_pkgshare} ~/.swamp

      Choose the option that works best for your workflow.

      Executable is available as: `fengrove`
    EOS
    s
  end
end