{ pkgs, flake, ... }:
let
  inherit (pkgs) stdenv lib;

  names = lib.pipe (flake + "/zig") [
    (dir: builtins.readDir dir)
    (contents: lib.attrsToList contents)
    (contentsList: builtins.filter ({ value, ... }: value == "directory") contentsList)
    (childDirs: builtins.map ({ name, ... }: name) childDirs)
  ];

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
  ) names;
in
pkgs.symlinkJoin {
  name = "zig-solutions";
  paths = derivations;
}
