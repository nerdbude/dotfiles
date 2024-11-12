{ config, pkgs, ... }:

### TMUX CONFIG

{
programs.tmux = {
	enable = true;
	clock24 = true;
	
	extraConfig = ''
		run-shell ${pkgs.tmuxPlugins.dracula}/share/tmux-plugins/dracula/dracula.tmux
	'';

};

}
