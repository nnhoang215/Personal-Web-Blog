defmodule AustinApiWeb.AdminControllerTest do
  use AustinApiWeb.ConnCase

  import AustinApi.AdminsFixtures

  alias AustinApi.Admins.Admin

  @create_attrs %{
    email: "some email",
    hash_password: "some hash_password"
  }
  @update_attrs %{
    email: "some updated email",
    hash_password: "some updated hash_password"
  }
  @invalid_attrs %{email: nil, hash_password: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all admins", %{conn: conn} do
      conn = get(conn, ~p"/api/admins")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create admin" do
    test "renders admin when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/admins", admin: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/admins/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email",
               "hash_password" => "some hash_password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/admins", admin: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update admin" do
    setup [:create_admin]

    test "renders admin when data is valid", %{conn: conn, admin: %Admin{id: id} = admin} do
      conn = put(conn, ~p"/api/admins/#{admin}", admin: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/admins/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "hash_password" => "some updated hash_password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, admin: admin} do
      conn = put(conn, ~p"/api/admins/#{admin}", admin: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete admin" do
    setup [:create_admin]

    test "deletes chosen admin", %{conn: conn, admin: admin} do
      conn = delete(conn, ~p"/api/admins/#{admin}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/admins/#{admin}")
      end
    end
  end

  defp create_admin(_) do
    admin = admin_fixture()
    %{admin: admin}
  end
end
