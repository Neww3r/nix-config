{ pkgs, ... }:
{
  stylix.image = pkgs.fetchurl {
    url = "https://get.wallhere.com/photo/anime-natural-light-landscape-forest-Studio-Ghibli-Karigurashi-no-Arrietty-1873503.jpg";
    sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  };
}
