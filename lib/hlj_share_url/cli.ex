defmodule HljShareUrl.CLI do
  
  @moduledoc """
    Handle the command line parsing
  """

  def main argv do
    argv |> parse_args |> process
  end

  def parse_args(args) do
    {options, [url], _} = OptionParser.parse(args)
    {:ok, url, options}
  end

  def process({:ok, url, options}) do
    IO.inspect HljShareUrl.from(url, options)
  end

end
