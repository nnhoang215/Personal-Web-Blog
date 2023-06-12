defmodule AustinApiWeb.AdminController do
  use AustinApiWeb, :controller

  alias AustinApi.Admins
  alias AustinApi.Admins.Admin

  action_fallback AustinApiWeb.FallbackController

  def index(conn, _params) do
    admins = Admins.list_admins()
    render(conn, :index, admins: admins)
  end

  def create(conn, %{"admin" => admin_params}) do
    with {:ok, %Admin{} = admin} <- Admins.create_admin(admin_params) do
      conn
      |> put_status(:created)
      |> render(:show, admin: admin)
    end
  end

  def show(conn, %{"id" => id}) do
    admin = Admins.get_admin!(id)
    render(conn, :show, admin: admin)
  end

  def update(conn, %{"id" => id, "admin" => admin_params}) do
    admin = Admins.get_admin!(id)

    with {:ok, %Admin{} = admin} <- Admins.update_admin(admin, admin_params) do
      render(conn, :show, admin: admin)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin = Admins.get_admin!(id)

    with {:ok, %Admin{}} <- Admins.delete_admin(admin) do
      send_resp(conn, :no_content, "")
    end
  end
end
