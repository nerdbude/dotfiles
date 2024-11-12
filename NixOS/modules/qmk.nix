{ config, pkgs, ... }:

### QMK CONFIG

{
	hardware.keyboard.qmk.enable = true;
	services.udev.packages = [ pkgs.qmk-udev-rules ];
}


