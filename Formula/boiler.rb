class Boiler < Formula
  desc "Boiler (Unsigned)"
  homepage "https://github.com/piot/boiler"

	MG_VERSION = "0.0.3" # brew is annoying that you can't use the normal version field
	version MG_VERSION
	# revision 2 # only need revision number if a previous git push was incorrect

	on_macos do
		on_arm do
			url "https://github.com/piot/boiler/releases/download/v#{MG_VERSION}/boiler-darwin-arm64.tar.gz"
			sha256 "7abf7896a732536a1c5a789262979e331b98f97c3be5e0bfb43fe03d28928058"
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
