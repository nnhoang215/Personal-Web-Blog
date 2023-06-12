defmodule AustinApiWeb.AssetControllerTest do
  use AustinApiWeb.ConnCase

  import AustinApi.AssetsFixtures

  alias AustinApi.Assets.Asset

  @create_attrs %{
    caption: "some caption",
    type: "some type",
    url: "some url"
  }
  @update_attrs %{
    caption: "some updated caption",
    type: "some updated type",
    url: "some updated url"
  }
  @invalid_attrs %{caption: nil, type: nil, url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all assets", %{conn: conn} do
      conn = get(conn, ~p"/api/assets")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create asset" do
    test "renders asset when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/assets", asset: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/assets/#{id}")

      assert %{
               "id" => ^id,
               "caption" => "some caption",
               "type" => "some type",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/assets", asset: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update asset" do
    setup [:create_asset]

    test "renders asset when data is valid", %{conn: conn, asset: %Asset{id: id} = asset} do
      conn = put(conn, ~p"/api/assets/#{asset}", asset: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/assets/#{id}")

      assert %{
               "id" => ^id,
               "caption" => "some updated caption",
               "type" => "some updated type",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, asset: asset} do
      conn = put(conn, ~p"/api/assets/#{asset}", asset: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete asset" do
    setup [:create_asset]

    test "deletes chosen asset", %{conn: conn, asset: asset} do
      conn = delete(conn, ~p"/api/assets/#{asset}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/assets/#{asset}")
      end
    end
  end

  defp create_asset(_) do
    asset = asset_fixture()
    %{asset: asset}
  end
end
