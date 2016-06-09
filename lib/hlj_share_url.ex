defmodule HljShareUrl do
  @moduledoc """
    Provide a function (HljShareUrl.form/2) to generate a url holding the sharing configuration data.
  """

  def main(args) do
    args |> parse_args |> process
  end

  def parse_args(args) do
    {options, [url], _} = OptionParser.parse(args)
    {:ok, url, options}
  end

  def process({:ok, url, options}) do
    IO.inspect from(url, options)
  end

  @doc """
  Generate a url with sharing config.

  ## Parameters

    - url: String that represents the raw url
    - setting: Keyword list representing the config. There are three keywords supported right now:
      - title: String representing the title when sharing
      - sub_title: String representing the sub title when sharing
      - icon: String representing the url of icon image when sharing

  ## Examples
  
    iex> HljShareUrl.from("http://example.com/test.html", title: "Sharing")
    "http://example.com/test.html?title=Sharing"

  """
  def from(url, setting) do
    URI.parse(url)
    |> inject_uri(setting)
  end

  defp inject_uri uri, setting do
    query = inject_query uri.query, setting
    parts = [];

    if uri.scheme do
      parts = parts ++ [uri.scheme, "://", uri.authority]
    end

    parts = parts ++ [uri.path]

    unless query == %{} do
      parts = parts ++ ["?", URI.encode_query(query)]
    end

    if uri.fragment do
      parts = parts ++ ["#", uri.fragment]
    end

    Enum.join parts
  end

  defp inject_query nil, setting do
    inject_query "", setting
  end

  defp inject_query query, setting do
    query
    |> URI.decode_query()
    |> Map.merge(setting[:title]      && %{hlj_title:     setting[:title]} || %{})
    |> Map.merge(setting[:sub_title]  && %{hlj_content:   setting[:sub_title]} || %{})
    |> Map.merge(setting[:icon]       && %{hlj_icon_url:  setting[:icon]} || %{})
  end
end
