{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Prompt. Zsh only: bash keeps its hand-rolled git-branch PS1.
  programs.starship = {
    enable = true;
    enableBashIntegration = false;
  };
}
