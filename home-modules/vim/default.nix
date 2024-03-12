{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
      coc-nvim
      coc-rust-analyzer
      gruvbox
      vim-airline
      vim-airline-themes
      vim-fugitive
      vim-wakatime
      vim-surround
    ];
    extraConfig = builtins.readFile ./vimrc;
  };

  home.packages = with pkgs; [
    # Fonts for vim-airline
    powerline-fonts

    ### Language servers for autocompletion ###

    # C
    clang-tools_16

    # Nix
    nil
    nixpkgs-fmt

    # Rust
    rust-analyzer
  ];

  home.file = {
    ".vim/coc-settings.json".source = ./coc-settings.json;
  };
}
