{
  nixvim = {
    enable = true;
    colorschemes.rose-pine.enable = true;
    plugins = {
      # This gives every parenthesis a different color
      rainbow-delimiters.enable = true;
      treesitter.enable = true;
      cmp-dictionary.enable = true;
      cmp-nvim-lsp.enable = true;
      comment-nvim.enable = true; # Provides easy keybindings to comment a line or multiple lines
      airline.enable = true; # Fancy statusbar
      coq-nvim = {
	enable = true; # Autocompletion display
	autoStart = true;
      };
      lsp = {
        enable = true;
	servers = {
	  gopls.enable = true; # Golang LSP
	  rust-analyzer.enable = true; # Rust LSP
	  nil_ls.enable = true; # Nix LSP
	  jsonls.enable = true; # JSON LSP
	  yamlls.enable = true; # YAML LSP
	};
      };
      telescope = {
	enable = true;
	keymaps = {
	  "<space>gf" = {
	    action = "git_files";
	    desc = "Telescope git files";
	  };
	  "<space>ff" = {
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
