{ pkgs ? import ./nix/pinned-nixpkgs.nix {} }:

let
  py-dev = with pkgs.python37Packages; [
    jedi
    python-language-server
    pyls-black
    pyls-isort
    pyls-mypy
  ];
in
(import ./default.nix {}).overrideAttrs (old: rec {
  buildInputs = old.buildInputs ++ py-dev;
})
