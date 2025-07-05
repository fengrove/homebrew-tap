class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/fengrove"

	MG_VERSION = "0.1.5" # brew is annoying that you can't use the normal version field
	version MG_VERSION
	revision 1 # only need revision number if a previous git push was incorrect

	on_arm do
		url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/mangrove-darwin-arm64.tar.gz"
		sha256 "95623e4ba0572204b9bbd3f81e686466f5fb7042fb25769b95a3ed6466d98d6f"
	end

	#on_intel do
	#  url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/mangrove-darwin-amd64.tar.gz"
	#  sha256 ""
	#end

	# Single resource for all architectures
	resource "packages" do
		url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/packages.tar.gz"
		sha256 "8626bef3afb8da34ac4be9abd0680aa8f39fa9dbe704a5bbf12745382fe3a67f"
	end


	def install
		prefix.install Dir["mangrove/*"]
		system "xattr", "-cr", prefix

		bin.install "mangrove" => "mangrove"

		# Homebrew has a pretty strange behavior where it extracts a tar.gz file
		# in different ways, depending on the structure and/or how many files are within the archive.
		# So we have to do a manual copy instead of the more cool `(pkgshare/"packages").install Dir["mangrove"]`
		resource("packages").stage do
			dest = pkgshare/"packages"
			dest.mkpath
			FileUtils.cp_r Dir["*"], dest
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