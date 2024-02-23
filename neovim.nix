{
  nixvim = {
    enable = true;
    clipboard.providers.wl-copy.enable = true; # Enable the wayland clipboard
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    globals.mapleader = " ";
    keymaps = [
      {
	mode = "n";
	key = "<leader>ee";
	# Expands the LSP error message (useful when the message is longer than a line, because the LSP doesn't have line wrap
	action = "<cmd>lua vim.diagnostic.open_float()<CR>";
	options = {
	  silent = true;
	};
      }
    ];
    plugins = {
      rainbow-delimiters.enable = true; # This gives every parenthesis a different color
      treesitter.enable = true; # Fancy Syntax highlighting plugin
      cmp-dictionary.enable = true;
      cmp-nvim-lsp.enable = true;
      comment-nvim.enable = true; # Provides easy keybindings to comment a line or multiple lines
      airline.enable = true; # Fancy statusbar
      todo-comments.enable = true; # Shows the TODO comments in a colorful way
      nvim-autopairs = {
	enable = true; # Bracket autoclose plugin
	checkTs = true;
      };
 #      coq-nvim = {
	# enable = true; # Autocompletion display
	# autoStart = true;
 #      };
      lsp = {
        enable = true;
	servers = {
	  gopls.enable = true; # Golang LSP
	  rust-analyzer = {
	    enable = true; # Rust LSP
	    installRustc = false;
	    installCargo = false;
	  };
	  nil_ls.enable = true; # Nix LSP
	  jsonls.enable = true; # JSON LSP
	  yamlls.enable = true; # YAML LSP
	  pylsp.enable = true; # Python LSP
	  clangd.enable = true; # C/C++ LSP
	};
      };
      telescope = {
	enable = true;
	keymaps = {
	  "<leader>gf" = {
	    action = "git_files";
	    desc = "Telescope git files";
	  };
	  "<leader>ff" = {
	    action = "find_files";
	    desc = "Telescope files generally";
	  };
	};
      };
    }; 
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
  };
}
