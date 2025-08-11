class Boiler < Formula
  desc "Boiler (Unsigned)"
  homepage "https://github.com/piot/boiler"

	MG_VERSION = "0.0.2" # brew is annoying that you can't use the normal version field
	version MG_VERSION
	# revision 2 # only need revision number if a previous git push was incorrect

	on_macos do
		on_arm do
			url "https://github.com/piot/boiler/releases/download/v#{MG_VERSION}/boiler-darwin-arm64.tar.gz"
			sha256 "8a3921dd075039e105d16bdf6cebd193e168f33e6a0f2a43b2e8da0cd88cb115"
		end
	end

	on_linux do
	end

	def install
		prefix.install Dir["boiler/*"]
		system "xattr", "-cr", prefix

		bin.install "boiler" => "boiler"
	end

end
