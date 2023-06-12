defmodule AustinApiWeb.AssetController do
  use AustinApiWeb, :controller

  alias AustinApi.Assets
  alias AustinApi.Assets.Asset

  action_fallback AustinApiWeb.FallbackController

  def index(conn, _params) do
    assets = Assets.list_assets()
    render(conn, :index, assets: assets)
  end

  def create(conn, %{"asset" => asset_params}) do
    with {:ok, %Asset{} = asset} <- Assets.create_asset(asset_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/assets/#{asset}")
      |> render(:show, asset: asset)
    end
  end

  def show(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)
    render(conn, :show, asset: asset)
  end

  def update(conn, %{"id" => id, "asset" => asset_params}) do
    asset = Assets.get_asset!(id)

    with {:ok, %Asset{} = asset} <- Assets.update_asset(asset, asset_params) do
      render(conn, :show, asset: asset)
    end
  end

  def delete(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)

    with {:ok, %Asset{}} <- Assets.delete_asset(asset) do
      send_resp(conn, :no_content, "")
    end
  end
end
