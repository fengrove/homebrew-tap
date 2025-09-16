class Boiler < Formula
  desc "Boiler (Unsigned)"
  homepage "https://github.com/piot/boiler"

	MG_VERSION = "0.0.6" # brew is annoying that you can't use the normal version field
	version MG_VERSION
	# revision 2 # only need revision number if a previous git push was incorrect

	on_macos do
		on_arm do
			url "https://github.com/piot/boiler/releases/download/v#{MG_VERSION}/boiler-darwin-arm64.tar.gz"
			sha256 "72d69ea5705f4e9e927a131b9d03455a98d215c5b65257b9088eea5f7defd500"
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
