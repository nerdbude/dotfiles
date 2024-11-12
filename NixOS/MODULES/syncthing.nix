{ config, pkgs, ... }:

{
	services.syncthing = {
		enable = true;
		user = "pho";
		dataDir = "/home/pho/sync";
		configDir = "/home/pho/.config/syncthing";	
	};

}
