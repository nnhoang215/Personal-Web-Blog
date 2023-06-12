defmodule AustinApiWeb.AssetJSON do
  alias AustinApi.Assets.Asset

  @doc """
  Renders a list of assets.
  """
  def index(%{assets: assets}) do
    %{data: for(asset <- assets, do: data(asset))}
  end

  @doc """
  Renders a single asset.
  """
  def show(%{asset: asset}) do
    %{data: data(asset)}
  end

  defp data(%Asset{} = asset) do
    %{
      id: asset.id,
      type: asset.type,
      url: asset.url,
      caption: asset.caption
    }
  end
end
