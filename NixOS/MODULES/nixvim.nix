#
# 8"""8 8"""" 8"""8  8""""8 8""""8   8   8 8""""8 8""""
# 8   8 8     8   8  8    8 8    8   8   8 8    8 8
# 8e  8 8eeee 8eee8e 8e   8 8eeee8ee 8e  8 8e   8 8eeee
# 88  8 88    88   8 88   8 88     8 88  8 88   8 88
# 88  8 88    88   8 88   8 88     8 88  8 88   8 88
# 88  8 88eee 88   8 88eee8 88eeeee8 88ee8 88eee8 88eee
#
#[website] https://www.nerdbude.com
#[mail] post@nerdbude.com
#[mastodon] @0x17@corteximplant.com
#[github] https://www.github.com/nerdbude
#
#======================================================
# CONFIG FOR NIXVIM 
#======================================================

{ modules, config, pkgs, lib, ... }:

let
    nixvim = import (builtins.fetchGit {
        url = "https://github.com/nix-community/nixvim";
    });
in

{
    imports = [nixvim.nixosModules.nixvim];

    programs.nixvim = {
        
	# BASE CONFIG
	enable = true;
	defaultEditor = true;
	# COLORSCHEME 
	colorschemes = {
		dracula-nvim = {
			enable = true;
		};	
	};

	# PLUGINS
	plugins = {
        nvim-tree = {
            enable = true;
        };
        
        telescope = {
			enable = true;
		};
		lualine = {
			enable = true;
		};
		alpha = {
			enable = true;
			theme = "startify";
		};
		web-devicons = {
			enable = true;
			settings = {
				color_icons = true;
				strict = true;
			};
		};
		vim-css-color = {
			enable = true;
		};
		barbecue = {
			enable = true;
		};
        fugitive = {
			enable = true;
		};
		nix = {
			enable = true;
		};
          };
      opts = {
           number = true;
           relativenumber = true;
           tabstop = 4;
           cursorline = true;
           scrolloff  = 4;
           splitright = true;

      };
      keymaps = [
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
          options = {
            desc = "Go to left window";
            remap = true;
          };
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
          options = {
            desc = "Go to lower window";
            remap = true;
          };
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
          options = {
            desc = "Go to upper window";
            remap = true;
          };
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
          options = {
            desc = "Go to right window";
            remap = true;
          };
        }
      ];

    };
}

