# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, nixpkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.allowed-users = [ "root" "lazywithclass" ];
  nix.settings.trusted-users = [ "root" "lazywithclass" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "acpi_backlight=video"
    "nvidia_drm.modeset=1"
    "i915.enable_dpcd_backlight=1"
    "i915.enable_psr=0"
    "nvidia.NVreg_EnableBacklightHandler=0"
    "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=0"
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ];
  boot.kernelModules = [ "i2c-dev" "acpi_call" ];

  boot.enableContainers = true;

  systemd.services.disable-panel-cabc = {
    description = "Disable ASUS panel content-adaptive brightness (CABC)";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      echo '\_SB.ATKD.WMNB 0x0 0x53564544 {0x2A, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}' > /proc/acpi/call
    '';
  };

  programs.steam = {
    enable = true;
  };

  programs.dconf.enable = true;

  services.geoclue2.enable = true;
  # TODO this should be automatic
  location.provider = "manual";
  location.latitude = 45.4722;
  location.longitude = 9.1922;

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  powerManagement.enable = true;

  programs.nix-ld.enable = true;

  networking.hostName = "dagobah";

  # Enable networking
  networking.networkmanager.enable = true;
  # Enable network manager applet
  programs.nm-applet.enable = true;

  networking.nameservers = [ "8.8.8.8" "8.8.4.4" "1.1.1.1" ];

  services.openvpn.servers = {}; # starts manually
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];
  services.dbus.packages = [ pkgs.openvpn3 ];
  systemd.packages = [ pkgs.openvpn3 ];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  }; 

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      # plasma6.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu    # application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock   # default i3 screen locker
        i3blocks # if you are planning on using i3blocks over i3status
     ];
    };
    
    xkb = {
      layout = "us";
      variant = "";
    };

    videoDrivers = [ "nvidia" ];

    extraConfig = ''
  Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "AccelSpeed" "-0.1"
    Option "ScrollPixelDistance" "50"
  EndSection

  Section "InputClass"
    Identifier "ignore-ascf-mouse"
    MatchProduct "ASCF1400:00 2808:0242 Mouse"
    Option "Ignore" "true"
  EndSection
'';
    };

  services.displayManager = {
    defaultSession = "none+i3";
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # for Proton
  };

  services.acpid = {
    enable = true;
    handlers = {
      brightness-up = {
        event = "video/brightnessup*";
        action = "${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight set +10%";
      };
      brightness-down = {
        event = "video/brightnessdown*";
        action = "${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight set 10%-";
      };
    };
  };

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    prime = {
      sync.enable = true;
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };
      offload.enable = false;

      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.supergfxd.enable = true;

  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
    daemon.settings = {
      dns = [ "8.8.8.8" "4.4.4.4" ];
      builder.gc = {
        enabled = true;
        defaultKeepStorage = "10GB";
      };
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.i2c.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

    extraConfig.pipewire = {
      "99-shut-that-bloody-bell-up" = {
        "context.properties" = {
          "module.x11.bell" = false;
        };
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      horizontalScrolling = true;
      tapping = false;
    };
  };

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # also, groups
  users.users.lazywithclass = {
    isNormalUser = true;
    description = "Alberto Zaccagni";
    extraGroups = [ "networkmanager" "wheel" "docker" "tty" "dialout" "video" "input" "i2c" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    pkgs.asusctl
    pkgs.ddcutil
    pkgs.nvtopPackages.nvidia  # GPU monitoring, useful to verify GPU is actually used
    pkgs.pinentry-curses
    pkgs.brightnessctl
    pkgs.supergfxctl
  ];

  environment.etc."libinput/local-overrides.quirks".text = ''
    [ASCF1400 Touchpad]
    MatchName=ASCF1400:00 2808:0242 Touchpad
    ModelBouncingKeys=1
  '';

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 2882 ];
  };

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
  system.stateVersion = "25.05"; # Did you read the comment?
}
