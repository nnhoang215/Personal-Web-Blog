defmodule AustinApiWeb.AdminController do
  use AustinApiWeb, :controller

  alias AustinApi.Admins
  alias AustinApi.Admins.Admin
  alias AustinApiWeb.Auth.{Guardian, ErrorResponse}

  action_fallback AustinApiWeb.FallbackController
 
  def index(conn, _params) do
    admins = Admins.list_admins()
    render(conn, :index, admins: admins)
  end

  def create(conn, %{"admin" => admin_params}) do
    with {:ok, %Admin{} = admin} <- Admins.create_admin(admin_params),
      {:ok, token, _claims} <- Guardian.encode_and_sign(admin) do
      conn
      |> put_status(:created)
      |> render(:admin_token, %{admin: admin, token: token})
    end
  end
  
  #parsing json you gotta hash the password before sending it to the database to fend against mitm.
  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, admin, token} ->
        conn
        |> put_status(:ok)
        |> render(:admin_token, %{admin: admin, token: token})
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or Password incorrect"
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
