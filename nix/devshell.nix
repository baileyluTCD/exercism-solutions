{ pkgs }:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    exercism
    zig
  ];
}
