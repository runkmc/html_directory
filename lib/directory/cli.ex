defmodule Directory.CLI do

  @moduledoc """
  Handle command line parsing for generating an HTML layout from a given CSV
  file.
  """

  @default_name "directory.html"

  def run(argv) do
    argv |> parse_args
  end

  @doc """
  'argv' can be -h or --help which returns :help.

  Otherwise it is a CSV file, with an optional output name.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    case parse do
      { [help: true], _, _} -> :help
      { _, [csv_filename], _ } -> { csv_filename, @default_name }
      { _, [csv_filename, directory_filename], _ } -> { csv_filename, directory_filename }
    end
  end

end
