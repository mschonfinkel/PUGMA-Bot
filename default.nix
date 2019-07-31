{ pkgs ? import ./nix/pinned-nixpkgs.nix {} }:

let
  python-decouple = pkgs.python37Packages.buildPythonPackage rec {
    pname = "python-decouple";
    version = "3.1";
    name = "${pname}-${version}";
    src = pkgs.python37Packages.fetchPypi {
      inherit pname version;
      sha256 = "0bgyqk44wiz6jkc4nv3dsl602kq0pwa2k82ag8ry9ziynhady5qk";
    };
  };

  py-pkgs = with pkgs.python37Packages; [
    pytest
    python-telegram-bot
    requests
  ];

  extra-py-pkgs = [ python-decouple ];

  system-pkgs = with pkgs; [
    python37Full
  ];
in
pkgs.stdenv.mkDerivation rec {
  name = "py-env-${version}";
  version = "0.0.1";
  buildInputs = system-pkgs ++ py-pkgs ++ extra-py-pkgs;
}

