class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/fengrove"
  url "https://github.com/fengrove/fengrove/releases/download/v0.0.31/mangrove-darwin-x86_64.tar.gz"
  version "0.0.31"
  sha256 "28554b13bb0bd855b15669327cecdfa3dd9912b999e69aca5c6c4615fab49c15"

  resource "packages" do
    url "https://github.com/fengrove/fengrove/releases/download/v0.0.31/packages.tar.gz"
    sha256 "83c15b37c4aa481a2a17d259381fde9b16479d9f4e5f6b01afe7feb4cee7b321"
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