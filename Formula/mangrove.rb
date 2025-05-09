class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/fengrove"
  url "https://github.com/fengrove/fengrove/releases/download/v0.0.34-alpha.1/mangrove-darwin-arm64.tar.gz"
  version "0.0.34-alpha.1"
  sha256 "4aac4559482baa9a937163b7ef65be0b3974b4be3d72bb468ba6550535b3d743"

  resource "packages" do
    url "https://github.com/fengrove/fengrove/releases/download/v0.0.34-alpha.1/packages.tar.gz"
    sha256 "f126c766a6dbf161b08ee6d1398ea30bf53168a7742cbfcce2d4261741bb11a7"
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