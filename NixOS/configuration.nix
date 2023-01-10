# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
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
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.utf8";

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "de";
    xkbVariant = "";
  xkbOptions = "eurosign:e";
  windowManager.xmonad.enable = true;
  windowManager.xmonad.enableContribAndExtras = true;
  autorun = true;
  };
  
  services.xserver = {
    displayManager = {
      startx.enable = false; 
      lightdm.enable = true;
    };
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pho = {
    isNormalUser = true;
    description = "pho";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Set ZSH as Default 
  users.defaultUserShell = pkgs.zsh; 

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # FONTS
  fonts.fonts = with pkgs; [
	(nerdfonts.override { fonts = [ "FiraCode" "ShareTechMono" ]; })
    
        ibm-plex
        google-fonts
        noto-fonts
];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =  with pkgs; [
    
# Editor
    vim
# Terminal tools
    nmap
    tldr
    vimb
    borgbackup
    gh
    git
    wget
    neofetch
    goaccess
    acpi
    xbrightness
    xorg.xrandr
    xcompmgr
    toot
    vifm
    networkmanager
    unzip
    img2pdf
    lynx
    canto-curses
    wtf
    sxiv
    toilet
    figlet
    sc-im
    cmatrix
    p7zip
    gomuks
    zsh-git-prompt
# Tools
    baobab
    drawio
    firefox
    thunderbird
    nitrogen  
    atom
    gimp
    filezilla
    zathura
    dmenu
    libreoffice
    qcad
    discord
    rofi
    inkscape
# Terminal
    zsh
    rxvt_unicode
    oh-my-zsh
    nerdfonts
# Languages
    python310
#   VNC TEST 
    tigervnc   
# Haskell Packages
    haskellPackages.libmpd
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras

  ];

  # ZSH CONFIG
  programs.zsh = {
	enable = true; 
	shellAliases = {
         ll = "ls -l";
         update = "sudo nixos-rebuild swicth";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "22.05"; # Did you read the comment?

}
