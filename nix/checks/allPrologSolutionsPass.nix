{ pkgs, flake, ... }:
let
  inherit (pkgs) stdenvNoCC lib;

  names = lib.pipe (flake + "/prolog") [
    (dir: builtins.readDir dir)
    (contents: lib.attrsToList contents)
    (contentsList: builtins.filter ({ value, ... }: value == "directory") contentsList)
    (childDirs: builtins.map ({ name, ... }: name) childDirs)
  ];

  derivations = builtins.map (
    name:
    stdenvNoCC.mkDerivation {
      name = "prolog-solution-${name}";
      src = (flake + "/prolog/" + name);

      nativeBuildInputs = with pkgs; [
        swi-prolog
        flake.packages.${system}.test-prolog
      ];

      dontBuild = true;
      doCheck = true;

      checkPhase = "test-prolog";

      installPhase = ''
        mkdir -p "$out"
      '';
    }
  ) names;
in
pkgs.symlinkJoin {
  name = "prolog-solutions";
  paths = derivations;
}
