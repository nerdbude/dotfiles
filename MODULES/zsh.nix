{ config, pkgs, ... }:

### ZSH CONFIG

{
	users.defaultUserShell = pkgs.zsh;
	programs.zsh = {
		enable = true;
        ohMyZsh = {
			enable = true;
			theme = "philips";
			plugins = [ "themes" "colorize" "git" "colored-man-pages" "ssh" ];
		};
		shellAliases = {
		    podcast = "podboat -C ~/home/pho/.config/podboat/pod-config";
			vim = "nvim";
			ll = "ls -l";
			update = "sh ./SCRIPTS/rebuilddiff.sh";
			upgrade = "sh ./SCRIPTS/upgrade.sh";
			garbage = "sudo nix-collect-garbage";
			reddit="tuir";
			wlan="nmtui";
			matrix="iamb";
			status="python /home/pho/SCRIPTS/ping.py";
			email="aerc";
			options="cat ./SCRIPTS/options";
			accesspoint="sh ./SCRIPTS/accesspoint.sh";
			uconsole="ssh pho@192.168.0.94";
		};

	};
}


