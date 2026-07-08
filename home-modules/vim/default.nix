{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      coc-nvim
      # coc-rust-analyzer
      coc-snippets
      gruvbox
      vim-airline
      vim-airline-themes
      vim-fugitive
      vim-wakatime
      vim-surround
      vim-snippets
    ];
    extraConfig = ''
      " coc.nvim runs its extension host on node, which isn't in PATH
      let g:coc_node_path = '${pkgs.nodejs}/bin/node'
    '' + builtins.readFile ./vimrc;
  };

  home.packages = with pkgs; [
    # Fonts for vim-airline
    powerline-fonts

    ### Language servers for autocompletion ###

    # Nix
    nil
    nixpkgs-fmt
  ];

  home.file = {
    ".vim/coc-settings.json".source = ./coc-settings.json;
  };
}
