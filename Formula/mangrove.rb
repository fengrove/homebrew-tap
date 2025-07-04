class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/fengrove"

	MG_VERSION = "0.1.4" # brew is annoying that you can't use the normal version
	version MG_VERSION
	revision 1 # remove this later

	on_arm do
		url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/mangrove-darwin-arm64.tar.gz"
		sha256 "f9091b78d270f5cbdc872c13c162ea3350379c83e6ec25ca16a384d2ee8aa4e9"
	end

	#on_intel do
	#  url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/mangrove-darwin-amd64.tar.gz"
	#  sha256 ""
	#end

	# Single resource for all architectures
	resource "packages" do
		url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/packages.tar.gz"
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