class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/mangrove"
  url "https://github.com/swamp/mangrove/releases/download/v0.0.22/mangrove-darwin-x86_64.tar.gz"
  version "0.0.22"
  sha256 "de31e5790eaef7321b98d2940c4710d8fb834b41ba81cea5fa43e676068d9d1c"

  resource "packages" do
    url "https://github.com/swamp/mangrove/releases/download/v0.0.22/packages.tar.gz"
    sha256 "45252690fb86dacec11474737b28866b5de6c830466e4eb1f9752493a049ac3a"
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