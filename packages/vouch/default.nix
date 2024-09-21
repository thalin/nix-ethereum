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
  pname = "vouch";
  version = "1.9.0";
  src = fetchFromGitHub {
    owner = "attestantio";
    repo = "vouch";
    rev = "v1.9.0";
    sha256 = "1dj278v68l8q7zr050qwcjihfsk7allkd6mzy2r82dpxywalrw0h";
  };
  modules = ./gomod2nix.toml;
}
