{ modules, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/tmux.nix
      ./modules/qmk.nix
      ./modules/zsh.nix
      ./modules/syncthing.nix
      ./modules/nixvim.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Networking / Hostname
  networking.hostName = "NB-IF-00"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Timezone
  time.timeZone = "Europe/Berlin";

  # Touchpad support
  services.libinput.enable = true;

  # Language
  i18n.defaultLocale = "de_DE.utf8";

  # X11 Keymap
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

  # Terminal Keymap
  console.keyMap = "de";

  # Useraccount (set password with passwd)
  users.users.pho = {
    isNormalUser = true;
    description = "pho";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Defualt shell ZSH
  #users.defaultUserShell = pkgs.zsh; 

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = ["libxls-1.6.2"];

  # Packages 
  environment.systemPackages =  with pkgs; [
  # System
    xbanish  
    nvd
  # GIT
    git
    lazygit
  # Editor
  #  vim
    gedit
  # Games
    cataclysm-dda
  # Mail
    aerc
  # AVR
    avrdudess
  # Terminal tools
    cmus
    linux-wifi-hotspot
    lnav
    tuir
    go-2fa
    libreoffice
    nix-tree
    btop
    nmap
    tldr
    borgbackup
    zip
    ranger
    gh
    wget
    goaccess
    acpi
    xbrightness
    xorg.xrandr
    xcompmgr
    tut
    vifm
    networkmanager
    unzip
    img2pdf
    wtf
    sxiv
    toilet
    figlet
    p7zip
    iamb
    remmina
    ventoy-bin-full
  # Tools
    baobab
    buku
    calcure
    croc
    kbt
    watchmate
    drawio
    inetutils
    ssh-audit
    firefox
    obsidian
    qutebrowser 
    thunderbird
    nitrogen  
    gimp
    zathura
  # libreoffice
    rofi
    newsboat
  # Terminal
    alacritty
    rxvt_unicode
  # Languages
    python310
  # KEYBOARDS
    vial 
    qmk
    qmk_hid
    qmk-udev-rules
  # Haskell Packages
    ghc
    haskellPackages.libmpd
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras

  ];

 
  programs.nix-ld.enable = true;

  system.stateVersion = "22.05"; # Did you read the comment?

}
