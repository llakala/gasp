{ stdenv, fetchFromGitHub, pkgs }:

stdenv.mkDerivation {
  pname = "splitpatch";
  version = "TEST";

  src = fetchFromGitHub {
    owner = "jaalto";
    repo = "splitpatch";
    rev = "256cb7b5beab2234395096617593d63025f443e0"; # Pointing to my own PR
    hash = "sha256-Li4vjov+w7S7uxrGYRrRq7+p4LqM9Bhk6HVx4MBFMzI=";
  };

  buildInputs = with pkgs; [
    perl
    ruby
  ];

  prePatch = ''
    substituteInPlace Makefile \
      --replace /usr/bin/install "install" \
  '';

  makeFlags = [ "PREFIX=$(out)" ];
}
