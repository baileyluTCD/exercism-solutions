{ pkgs }:
pkgs.writeShellApplication {
  name = "test-prolog";
  runtimeInputs = with pkgs; [
    swi-prolog
  ];
  text = ''
    if [ "$#" -gt 0 ]; then
      work_dir="$1"
      cd "$1"
    else
      work_dir="$(pwd)"
    fi

    echo "Running tests in $work_dir..."

    file=$(find ./*.pl | head -n 1)
    test_file=$(find ./*.plt | head -n 1)

    exec swipl -f "$file" -s "$test_file" -g run_tests,halt -t 'halt(1)' -- --all
  '';
}
