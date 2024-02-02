# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			./keyd.nix
		];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/New_York";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS        = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT    = "en_US.UTF-8";
		LC_MONETARY       = "en_US.UTF-8";
		LC_NAME           = "en_US.UTF-8";
		LC_NUMERIC        = "en_US.UTF-8";
		LC_PAPER          = "en_US.UTF-8";
		LC_TELEPHONE      = "en_US.UTF-8";
		LC_TIME           = "en_US.UTF-8";
	};

	# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	# Wooting Keyboard
	hardware.wooting.enable = true;

	# Backlight & Other LEDs
	programs.light.enable = true;


	# SOUND Enable sound with pipewire.
	sound.enable = true;
	security.rtkit.enable = true;
	services.pipewire = {
		enable            = true;
		alsa.enable       = true;
		alsa.support32Bit = true;
		pulse.enable      = true;
		jack.enable       = true;
	};


	# GRAPHICS
	hardware = {
		opengl.enable = true;
	};

	programs.hyprland = {
		enable          = true;
		xwayland.enable = true;
	};
	programs.waybar.enable = true;
	environment.sessionVariables.NIXOS_OZONE_WL = "1";


	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;
	

	# SYSTEM ENVIRONMENT
	programs.fish = {
		enable = true;
		loginShellInit = "exec Hyprland";
		shellAbbrs = {
			h = "hx";
			x = "exit";
			nixcon = "sudo hx /etc/nixos/configuration.nix";
			conf = "hx /home/c/.config/";
			sofish = "source /home/c/.config/fish/config.fish";
			mellc = "cd /home/c/local/MELLC-metarepo/";
		};
	};
	users.defaultUserShell = pkgs.dash;

	environment = {
		# SHELL
		## /bin/sh -> dash
		binsh = "${pkgs.dash}/bin/dash";

		shells = with pkgs; [ fish dash ];

		variables = { EDITOR = "hx"; };
		
		# PACKAGES system
		# $ nix search wget
		systemPackages = with pkgs; [
			dash
			curl
			wget

			helix

			lf
			bat
			fzf
			ripgrep

			tldr

			neofetch
			btop

			playerctl
			networkmanagerapplet
			gammastep

			keyd
			wootility
			wooting-udev-rules
		];
	};

	# USER
	users.users.c = {
		isNormalUser = true;
		description = "c";
		extraGroups = [ "keyd" "input" "audio" "video" "networkmanager" "wheel" ];
		shell = pkgs.fish;

		# PACKAGES user
		packages = with pkgs; [
			kitty
			foot

			dmenu
			wmenu

			# git
			gh
			pinentry
			gh-dash

			spotify

			microsoft-edge
			google-chrome

			vscode

			toipe
		];
	};

	# Enable automatic login for the user.
	services.getty.autologinUser = "c";

	fonts = {
		packages = with pkgs; [
			nerdfonts
			noto-fonts
		];

		fontconfig.defaultFonts.monospace = [ "Monaspace Argon" ];

		fontDir.enable = true;
		fontconfig.hinting.style = "slight";
	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	programs.git = {
		enable = true;
		lfs.enable = true;
	};

	programs.gnupg.agent = {
		enable                = true;
		# enableSSHSupport    = true;
		# enableBrowserSocket = true;
		pinentryFlavor        = null;
	};


	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?

}
