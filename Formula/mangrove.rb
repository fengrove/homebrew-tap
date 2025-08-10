class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/fengrove"

	MG_VERSION = "0.1.40" # brew is annoying that you can't use the normal version field
	version MG_VERSION
	# revision 2 # only need revision number if a previous git push was incorrect

	on_arm do
		url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/mangrove-darwin-arm64.tar.gz"
		sha256 "826365293fbcbe31bd86047ee515ae7dede574e2c483fdb4638002ba49ec05ab"
	end

	#on_intel do
	#  url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/mangrove-darwin-amd64.tar.gz"
	#  sha256 ""
	#end

	# Single resource for all architectures
	resource "packages" do
		url "https://github.com/fengrove/fengrove/releases/download/v#{MG_VERSION}/packages.tar.gz"
		sha256 "5c42a87a70c80d6d7733a80ad5bd7e6768bc951b9152babbbd1da2309f9b75d3"
	end


	def install
		prefix.install Dir["mangrove/*"]
		system "xattr", "-cr", prefix

		bin.install "mangrove" => "mangrove"

		# Homebrew has a pretty strange behavior where it extracts a tar.gz file
		# in different ways, depending on the structure and/or how many files are within the archive.
		# So the file must always contain at least two directories
		resource("packages").stage do
			(pkgshare/"packages").install Dir["mangrove"]
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