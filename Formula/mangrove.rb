class Mangrove < Formula
  desc "Mangrove (Unsigned)"
  homepage "https://github.com/mangrove"
  url "https://github.com/swamp/mangrove/releases/download/v0.0.15/mangrove-darwin-x86_64.tar.gz"
  version "0.0.15"
  sha256 "6fcf12cfafaa84657fb9485728c239c60d9965ca515eecfb1c8be58c31659421"

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