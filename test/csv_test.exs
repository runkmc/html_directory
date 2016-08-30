defmodule CSVTest do
  use ExUnit.Case

  test "headers are properly created" do
    headers = Directory.CSV.create_headers "HouseholdID,Family Name,Street
    (Permanent Address),City (Permanent Address),State (Permanent Address),Zip"
    assert Enum.member?(headers, :householdid)
  end

end
