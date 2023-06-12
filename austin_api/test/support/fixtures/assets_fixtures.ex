defmodule AustinApi.AssetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AustinApi.Assets` context.
  """

  @doc """
  Generate a asset.
  """
  def asset_fixture(attrs \\ %{}) do
    {:ok, asset} =
      attrs
      |> Enum.into(%{
        caption: "some caption",
        type: "some type",
        url: "some url"
      })
      |> AustinApi.Assets.create_asset()

    asset
  end
end
