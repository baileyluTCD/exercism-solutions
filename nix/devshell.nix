{ pkgs, flake }:
pkgs.mkShell {
  packages = with pkgs; [
    exercism

    zig_0_15

    swi-prolog
    flake.packages.${system}.test-prolog

    stack
  ];
}
