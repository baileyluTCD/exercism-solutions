{ pkgs }:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    exercism
    zig_0_15
  ];
}
