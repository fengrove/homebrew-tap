class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/mangrove"
  url "https://github.com/swamp/mangrove/releases/download/v0.0.8/mangrove-darwin-x86_64.tar.gz"
  version "0.0.8"
  sha256 "641d4d92a9fc7cf333a5275aed9b17f8e53c43cf8a25ba278c04abe0c8695cf4"

  def install
    prefix.install Dir["mangrove/*"]
    system "xattr", "-cr", prefix
    bin.install "mangrove" => "mangrove"

    # --- Install Default User Config File ---
    # config_dir = ~/.config/"mangrove"
    #FileUtils.mkdir_p config_dir
    #default_config_source = prefix/"config"/"default.config" # Assuming default.config is in 'config' dir in archive
    #user_config_dest = config_dir/"config.toml"

    #unless File.exist?(user_config_dest) # Only copy if user config doesn't exist
    #  FileUtils.cp default_config_source, user_config_dest
    #  puts "Created default config file at: #{user_config_dest}"
    #end

  end

  def caveats
    s = <<~EOS
      mangrove has been installed to:
        #{prefix}

      Executable is available as: `mangrove`
    EOS
    s
  end
end