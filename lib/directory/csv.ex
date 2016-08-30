defmodule Directory.CSV do

  @moduledoc """
  Turn a CSV file into a parsable format
  """

  def parse(filename) do
    file = File.open!(filename)
    headers = create_headers(IO.read(file, :line))
  end

  def create_headers(line_of_headers) do
    line_of_headers
      |> String.strip
      |> String.replace(" ", "_")
      |> String.replace(~r{[\(\)]}, "")
      |> String.downcase
      |> csv_data(&String.to_atom/1)
  end

  defp csv_data(line, fun) do
    line
      |> String.strip
      |> String.split(",") 
      |> Enum.map(fun)
  end

end
