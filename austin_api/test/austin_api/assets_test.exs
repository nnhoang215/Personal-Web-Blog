defmodule AustinApi.AssetsTest do
  use AustinApi.DataCase

  alias AustinApi.Assets

  describe "assets" do
    alias AustinApi.Assets.Asset

    import AustinApi.AssetsFixtures

    @invalid_attrs %{caption: nil, type: nil, url: nil}

    test "list_assets/0 returns all assets" do
      asset = asset_fixture()
      assert Assets.list_assets() == [asset]
    end

    test "get_asset!/1 returns the asset with given id" do
      asset = asset_fixture()
      assert Assets.get_asset!(asset.id) == asset
    end

    test "create_asset/1 with valid data creates a asset" do
      valid_attrs = %{caption: "some caption", type: "some type", url: "some url"}

      assert {:ok, %Asset{} = asset} = Assets.create_asset(valid_attrs)
      assert asset.caption == "some caption"
      assert asset.type == "some type"
      assert asset.url == "some url"
    end

    test "create_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assets.create_asset(@invalid_attrs)
    end

    test "update_asset/2 with valid data updates the asset" do
      asset = asset_fixture()
      update_attrs = %{caption: "some updated caption", type: "some updated type", url: "some updated url"}

      assert {:ok, %Asset{} = asset} = Assets.update_asset(asset, update_attrs)
      assert asset.caption == "some updated caption"
      assert asset.type == "some updated type"
      assert asset.url == "some updated url"
    end

    test "update_asset/2 with invalid data returns error changeset" do
      asset = asset_fixture()
      assert {:error, %Ecto.Changeset{}} = Assets.update_asset(asset, @invalid_attrs)
      assert asset == Assets.get_asset!(asset.id)
    end

    test "delete_asset/1 deletes the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{}} = Assets.delete_asset(asset)
      assert_raise Ecto.NoResultsError, fn -> Assets.get_asset!(asset.id) end
    end

    test "change_asset/1 returns a asset changeset" do
      asset = asset_fixture()
      assert %Ecto.Changeset{} = Assets.change_asset(asset)
    end
  end
end
