defmodule DirectoryTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest Directory

  test "creating the html" do
    assert String.contains?(capture_io(fn ->
      Directory.finish(:stdio, [%{addressee: "The Sisko Household"}])
    end), "Sisko")
  end
    
end
