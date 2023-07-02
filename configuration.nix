{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable Gnome Desktop environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Enable Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # Define a user account
  users.users.emre = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "kvm" "libvirt"];
  };

  # allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    wget
    curl
    flatpak
    git
    docker-compose
    neovim
    htop
    neofetch
    ungoogled-chromium
    firefox
    evince
    vscode
    gnome.gnome-terminal
    emacs29-pgtk
    gnome.gnome-tweaks
    distrobox
    ghc
    stack
    cabal-install
    haskell-language-server
    hlint
    stdenv
    gcc
    gnumake
    cmake
    libvterm
    libtool
    pkgconfig
    libvirt
    qemu_kvm
    qemu
    virt-manager
  ];

  # Qemu Kvm configs
  boot.kernelModules = ["kvm-intel"];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.package = pkgs.libvirt;
  virtualisation.libvirtd.extraConfig = ''
      user = "emre";
  '';
  programs.dconf.enable = true;
  
  # Some programs need SUID wrappers
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # Enable OpenSsh daemon
  services.openssh.enable = true;

  networking.firewall.enable = false;

  # Flatpak
  services.flatpak.enable = true;
  
  # Docker
  virtualisation.docker.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

    # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

