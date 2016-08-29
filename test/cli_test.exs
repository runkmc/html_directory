defmodule CLITest do
  use ExUnit.Case
  doctest Directory

  import Directory.CLI

  test ":help returned by option parsing with -h and --help" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test "one filename is returned if one is given" do
    assert parse_args(["filename.csv"]) == { "filename.csv", "directory.html" }
  end

  test "optional second filename is returned if given as well" do
    assert parse_args(["filename.csv", "new_file.html"]) == { "filename.csv", "new_file.html" }
  end

end
