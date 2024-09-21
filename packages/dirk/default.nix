{ pkgs ? (
    let
      inherit (builtins) fetchTree fromJSON readFile;
      inherit ((fromJSON (readFile ../../flake.lock)).nodes) nixpkgs gomod2nix;
    in
    import (fetchTree nixpkgs.locked) {
      overlays = [
        (import "${fetchTree gomod2nix.locked}/overlay.nix")
      ];
    }
  )
  , buildGoApplication ? pkgs.buildGoApplication,
  fetchFromGitHub
}:

buildGoApplication {
  pname = "dirk";
  version = "1.2.0";
  src = fetchFromGitHub {
    owner = "attestantio";
    repo = "dirk";
    rev = "v1.2.0";
    sha256 = "1k4b8jv6g6q0dcafa9lqy3jg6ciwf47w9lrxj93a0slyxl880ri1";
  };
  modules = ./gomod2nix.toml;
}
