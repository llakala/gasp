{ stdenv, fetchFromGitHub, pkgs, ... }:

stdenv.mkDerivation
{
  pname = "splitpatch";
  version = "TEST";

  src = fetchFromGitHub
  {
    owner = "jaalto";
    repo = "splitpatch";
    rev = "e9203c23c7d37777d0fb751b872f86e24244b1da"; # Pointing to my own PR
    hash = "sha256-hnA3VGyEB9423FR7Um5oP51nvROpFOLKsytq2BcrcOk=";
  };

  buildInputs = with pkgs;
  [
    perl
    ruby
  ];

  prePatch =
  ''
    substituteInPlace Makefile \
      --replace /usr/bin/install "install" \
  '';

  makeFlags = [ "PREFIX=$(out)" ];
}
