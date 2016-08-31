defmodule CSVTest do
  use ExUnit.Case

  test "headers are properly created" do
    file = File.open!("./test/test.csv")
    headers = Directory.CSV.create_headers(IO.read(file, :line))
    assert Enum.member?(headers, :householdid)
    assert Enum.member?(headers, :family_name)
    assert Enum.member?(headers, :street_permanent_address)
  end

  test "data is a list of maps" do
    data = Directory.CSV.parse("./test/test.csv")
    assert is_list(data)
    assert is_map(List.first data)
  end
 
  test "data is matched with correct headers" do
    data = Directory.CSV.parse("./test/test.csv")
    assert (List.first data)[:family_name] == "Sisko"
    assert (List.first data)[:members] == "\"Jake, Benjamin\""
    assert (List.first data)[:phone_numbers] == "\"\""
    assert (List.last data)[:street_permanent_address] == "900 Level St."
  end
end
