# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "vm-nixos"; # Define your hostname.

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/New_York";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.cv = {
		isNormalUser = true;
		description = "cv";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			git
			gh
			gnupg
			pinentry
			asdf-vm 
			firefox
			rofi-wayland
			mako
			libnotify
			networkmanagerapplet
		];
	};

	# Enable automatic login for the user.
	services.getty.autologinUser = "cv";

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		kitty
		wget
		curl
		zsh
		dash
		neovim
		ripgrep
		findutils
		fzf
		fd
		lf
		bat
		zoxide
		xz
		zstd
		brotli
	];

	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		syntaxHighlighting = {
			enable = true;
			highlighters = [ "main" "brackets" ];
		};
	};

	environment = {
		binsh = "${pkgs.dash}/bin/dash";
		shells = with pkgs; [ dash zsh ];
	};

	users.defaultUserShell = pkgs.zsh;

	programs.hyprland.enable = true;
	programs.waybar.enable = true;
	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
		withNodeJs = true;
		defaultEditor = true;
	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	programs.mtr.enable = true;
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	# Open ports in the firewall.
	networking.firewall.allowedTCPPorts = [ 3000 4174 5174 ];



	system.stateVersion = "23.05";

}
