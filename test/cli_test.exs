defmodule CLITest do
  use ExUnit.Case
  doctest Directory

  import Directory.CLI

  test ":help returned by option parsing with -h and --help" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

end
