defmodule Directory do

  def generate(filename, data) do
    file = File.open(filename, [:write, :exclusive])
    finish(file, data)
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
        <p class="members">#{listing[:members]}</p>
        <span class="member-address"><p>#{listing[:street_permanent_address]}</p>
        <p>#{listing[:city_permanent_address]}, #{listing[:state_permanent_address]} ##{listing[:zip_permanent_address]}</p></span>
        <p class="phone-number">#{listing[:phone_numbers]}</p>
        <a href="mailto:#{listing[:email_addresses]}">#{listing[:email_addresses]}</a>
      </div>
      """
    end
  end

end
