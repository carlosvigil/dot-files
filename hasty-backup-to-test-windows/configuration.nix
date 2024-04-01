# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			./dev-env.nix
		];
	
	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.settings.auto-optimise-store = true;
	
	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
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
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};
	
	services.keyd.enable = false;
	
	hardware = {
		opengl = {
			enable = true;
			extraPackages = with pkgs; [ intel-compute-runtime intel-media-driver ];
		};
		bluetooth.enable = true;
		wooting.enable = true;
	};
	
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
		# jack.enable       = true;
	};
	
	# DESKTOP
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};
	
	# systemd.user.services = {
	# 	lemurs = {
	# 		description = "lemurs login service";
	# 		serviceConfig = {
	# 			Type = "simple";
	# 			ExecStart = ''${pkgs.lemurs}/bin/lemurs'';
	# 		};
	# 	};
		
	# 	kanshi = {
	# 		description = "kanshi daemon";
	# 		serviceConfig = {
	# 			Type = "simple";
	# 			ExecStart = ''${pkgs.kanshi}/bin/kanshi -c /home/c/.config/kanshi/config'';
	# 		};
	# 	};
	# };
	
	## WINDOWS
	programs.hyprland = {
		enable          = true;
		xwayland.enable = true;
	};
	programs.waybar.enable = true;
	environment.sessionVariables.NIXOS_OZONE_WL = "1";
	
	
	# SYSTEM ENVIRONMENT
	users.defaultUserShell = pkgs.dash;
	
	
	environment = {
		# SHELL
		## /bin/sh -> dash
		binsh = "${pkgs.dash}/bin/dash";
		shells = with pkgs; [ fish dash ];
		localBinInPath = true;
		pathsToLink = [ "/share/fish" "/home/c/.local/bin" ];
		variables = {
			EDITOR = "hx";
			BATDIFF_USE_DELTA = "true";
			
			GOPATH = "$HOME/go";
			CARGO_BIN = "$HOME/.cargo/bin";
			PNPM_HOME = "$HOME/.local/share/pnpm";
			HELIX_RUNTIME = "$HOME/.config/helix/runtime";
			
			GEMINI_API_KEY = "";
		};
		# PACKAGES system
		# $ nix search wget
		systemPackages = with pkgs; [
			dash
			helix
			lf
			tmux
		];
	};
	
	programs.fish = {
		enable = true;
		loginShellInit = "exec Hyprland";
		shellAbbrs = {
			      h = "hx";
			    man = "batman";
			   mans = "complete -C\"\" | fzf | xargs man";
			  fzpath = "echo $PATH | tr ' ' '\n' | fzf";
			nixconf = "sudo hx /etc/nixos/configuration.nix";
			   conf = "sudo hx --working-dir /home/c/.config";
			 sofish = "source /home/c/.config/fish/config.fish";
			  mellc = "cd /home/c/local/MELLC-metarepo/";
		};
	};
	
	# USER
	# Enable automatic login for the user.
	services.getty.autologinUser = "c";
	
	users.users.c = {
		isNormalUser = true;
		description = "c";
		extraGroups = [ "keyd" "input" "audio" "video" "networkmanager" "wheel" ];
		
		# PACKAGES user
		packages = with pkgs; [
			# terminal
			kitty # main term
			foot # performant term, with client/server
			
			fishPlugins.tide
			
			# cli
			curl
			wget
			unzip
			
			## git
			gh
			pinentry
			gh-dash # gh dashboard
			delta
			fishPlugins.forgit
			
			## cli tool upgrades
			bat # cat replacement, auto calls pager
			bat-extras.batman
			bat-extras.batgrep
			bat-extras.batdiff
			bat-extras.batwatch
			entr
			bat-extras.prettybat
			fd # better find
			fzf # fuzzy finder
			fishPlugins.fzf-fish
			ripgrep
			btop # process/resource dashboard
			cliphist # wayland text & image clipboard
			
			## less important cli tools
			tree
			neofetch # pretty sys info
			tldr # cli commands snippets
			toipe # typing test
			appimage-run
			killall
			xdg-utils
			wl-clipboard
			lemurs
			
			# tiling window manager supplements
			dmenu
			wmenu # wayland launcher tool
			networkmanagerapplet # network applet
			# kanshi # wayland display profiles
			gammastep # reduce blue light
			
			# hw tools
			cyme # usb
			udiskie # usb auto-mount
			ventoy # create bootable media
			pavucontrol # audio controls
			ncpamixer # tui audio controls
			playerctl # media play
			#keyd # keyremapper
			wootility # proprietary keyboard config
			wooting-udev-rules # req for propriety keyboard config via browser
			
			# gui
			spotify
			microsoft-edge
			google-chrome
			vscode
		];
	};
	
	fonts = {
		packages = with pkgs; [
			nerdfonts
			noto-fonts
		];
		
		fontconfig.defaultFonts = {
			monospace = [ "MonaspiceAr Nerd Font Mono" ];
			sansSerif = [ "Noto Sans" ];
			    serif = [ "Noto Serif" ];
		};
		
		fontDir.enable = true;
		fontconfig.hinting.style = "slight";
	};
	
	programs.git = {
		enable = true;
		lfs.enable = true;
	};
	
	programs.gnupg.agent = {
		enable              = true;
		enableSSHSupport    = true;
		enableBrowserSocket = true;
		pinentryFlavor      = "curses";
	};
	
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?
}
