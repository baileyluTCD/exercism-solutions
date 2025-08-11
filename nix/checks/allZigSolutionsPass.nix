{ pkgs, flake, ... }:
let
  inherit (pkgs) stdenv lib;

  zig-dir = builtins.readDir (flake + "/zig");
  dir-contents = lib.attrsToList zig-dir;
  directories = builtins.filter ({ value, ... }: value == "directory") dir-contents;
  zig-solutions = builtins.map ({ name, ... }: name) directories;
  derivations = builtins.map (
    name:
    stdenv.mkDerivation {
      name = "zig-solution-${name}";
      src = (flake + "/zig/" + name);

      nativeBuildInputs = with pkgs; [
        zig.hook
      ];

      dontBuild = true;
      doCheck = true;

      checkPhase = ''
        file=$(ls | grep test | head)

        zig test "$file"
      '';

      installPhase = ''
        mkdir -p "$out"
      '';
    }
  ) zig-solutions;
in
pkgs.symlinkJoin {
  name = "zig-solutions";
  paths = derivations;
}
