{ pkgs, callPackage, buildGoApplication }:
rec
{
  dirk = callPackage ./dirk { inherit pkgs buildGoApplication; };
    default = throw ''Don't use default, use 'nix build .#<package name>' instead'';
}
