defmodule HljShareUrl do

  def from(url, setting) do
    URI.parse(url)
    |> inject_uri(setting)
  end

  defp inject_uri uri, setting do
    query = inject_query uri.query, setting
    parts = [uri.scheme, "://"]

    parts = parts ++ [uri.authority, uri.path]

    unless query == %{} do
      parts = parts ++ ["?", URI.encode_query(query)]
    end

    if uri.fragment do
      parts = parts ++ ["#", uri.fragment]
    end

    Enum.join parts
  end

  defp inject_query nil, setting do
    inject_query %{}, setting
  end

  defp inject_query query, setting do
    query
    |> Map.merge(setting[:title]      && %{hlj_title:     setting[:title]} || %{})
    |> Map.merge(setting[:sub_title]  && %{hlj_content:   setting[:sub_title]} || %{})
    |> Map.merge(setting[:icon]       && %{hlj_icon_url:  setting[:icon]} || %{})
  end
end
