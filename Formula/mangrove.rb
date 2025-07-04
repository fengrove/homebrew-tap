class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/fengrove"

	version "0.1.4"

	url "https://github.com/fengrove/fengrove/releases/download/v#{version}/mangrove-darwin-arm64.tar.gz"
	sha256 "f9091b78d270f5cbdc872c13c162ea3350379c83e6ec25ca16a384d2ee8aa4e9"

  resource "packages" do
    url "https://github.com/fengrove/fengrove/releases/download/v#{version}/packages.tar.gz"
    sha256 "8263e737b356423798129637716ad6d9a08536993d37cc5836eb16e9ef7c60be"
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