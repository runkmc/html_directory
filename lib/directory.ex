defmodule Directory do

  def main(args) do
    {csv, html} = Directory.CLI.run(args)
    members = Directory.CSV.parse(csv)
    generate(html, members)
  end

  def generate(filename, data) do
    {_,file} = File.open(filename, [:write, :exclusive])
    finish(file, data)
  end

  def strip_quotes(string) do
    String.replace(string, "\"", "")
  end

  def finish({:error, _}, _) do
    IO.puts "error: file already exists"
    System.halt(1)
  end

  def finish(file, data) do
    Enum.each data, fn(listing) ->
      IO.puts file, """
      <div class="directory-listing">
        <h1>#{listing[:addressee]}</h1>
        <p class="members">#{strip_quotes(listing[:members])}</p>
        <div class="member-address"><p>#{listing[:street_permanent_address]}</p>
        <p>#{listing[:city_permanent_address]}, #{listing[:state_permanent_address]} ##{listing[:zip_permanent_address]}</p></div>
        <p class="phone-number">#{listing[:phone_numbers]}</p>
        <a href="mailto:#{strip_quotes(listing[:email_addresses])}">#{strip_quotes(listing[:email_addresses])}</a>
      </div>
      """
    end
  end

end
