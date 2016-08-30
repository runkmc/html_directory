defmodule Directory.CSV do

  @moduledoc """
  Turn a CSV file into a list of maps
  """

  def parse(filename) do
    file = File.open!(filename)
    headers = create_headers(IO.read(file, :line))
    Enum.map(IO.stream(file, :line), &create_line(&1, headers))
  end

  def create_headers(line_of_headers) do
    line_of_headers
      |> String.trim
      |> String.replace(" ", "_")
      |> String.replace(~r{[\(\)]}, "")
      |> String.downcase
      |> csv_data(&String.to_atom/1)
  end

  def create_line(line, headers) do
    data = line 
      |> String.trim
      |> String.split(~r/,(?=(?:[^"]*"[^"]*")*[^"]*$)/)
    Enum.zip(headers, data) 
      |> Enum.into(%{})
  end

  defp csv_data(line, fun) do
    line
      |> String.trim
      |> String.split(",") 
      |> Enum.map(fun)
  end

end
