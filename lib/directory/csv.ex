defmodule Directory.CSV do

  @moduledoc """
  Turn a CSV file into a list of maps
  """

  def parse(filename) do
    file = File.open!(filename)
    headers = create_headers(IO.read(file, :line))
    members = Enum.map(IO.stream(file, :line), &create_line(&1, headers))
    Enum.sort(members, &(last_name(&1) < last_name(&2)))
  end

  def last_name(member) do
    {:ok,name} = Map.fetch(member, :addressee)
    Enum.at(String.split(name), 2)
  end

  def create_headers(line_of_headers) do
    line_of_headers
      |> String.trim
      |> String.replace(" ", "_")
      |> String.replace(~r{[\(\)]}, "")
      |> String.downcase
      |> String.split(",")
      |> Enum.map(&String.to_atom/1)
  end

  def create_line(line, headers) do
    data = line 
      |> String.trim
      |> String.split(~r/,(?=(?:[^"]*"[^"]*")*[^"]*$)/)
    Enum.zip(headers, data) 
      |> Enum.into(%{})
  end

end
