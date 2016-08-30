defmodule CSVTest do
  use ExUnit.Case

  test "headers are properly created" do
    headers = Directory.CSV.create_headers "HouseholdID,Family Name,Street (Permanent Address),City (Permanent Address),State (Permanent Address),Zip"
    assert Enum.member?(headers, :householdid)
    assert Enum.member?(headers, :family_name)
    assert Enum.member?(headers, :street_permanent_address)
  end

end
