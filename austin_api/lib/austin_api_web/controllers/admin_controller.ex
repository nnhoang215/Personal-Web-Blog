defmodule AustinApiWeb.AdminController do
  use AustinApiWeb, :controller

  alias AustinApi.Admins
  alias AustinApi.Admins.Admin
  alias AustinApiWeb.Auth.{Guardian, ErrorResponse}
  
  plug :is_authorized_account when action in [:update, :delete]

  action_fallback AustinApiWeb.FallbackController
 
  defp is_authorized_account(conn, _options) do
    %{params: %{"admin" => params}} = conn
    admin = Admins.get_admin!(params["id"])
    if conn.assigns.admin.id == admin.id do
      conn 
    else 
      raise ErrorResponse.Forbidden
    end
  end
  
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
        |> Plug.Conn.put_session(:admin_id, admin.id)
        |> put_status(:ok)
        |> render(:admin_token, %{admin: admin, token: token})
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or Password incorrect"
    end
  end

  def refresh_session(conn, %{}) do
    old_token = Guardian.Plug.current_token(conn)
    case Guardian.decode_and_verify(old_token) do
      {:ok, claims} ->
        case Guardian.resource_from_claims(claims) do
          {:ok, admin}-> 
            {:ok, _old, {new_token, _new_claims}} = Guardian.refresh(old_token)
              conn
              |> Plug.Conn.put_session(:admin_id, admin.id)
              |> put_status(:ok)
              |> render(:admin_token, %{admin: admin, token: new_token})
          {:error, _reason} ->
            raise ErrorResponse.NotFound
        end
      {:error, _reasons} ->
        raise ErrorResponse.NotFound
    end
  end
  
  def sign_out(conn, %{}) do
    admin = conn.assigns[:admin] # what if this was manually swept before signing out?
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token);
    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render(:admin_token, %{admin: admin, token: nil})
  end
  
  def show(conn, %{"id" => id}) do
    admin = Admins.get_admin!(id)
    render(conn, :show, admin: admin)
    # render(conn, :show, admin: conn.assigns.admin)
  end

  def update(conn, %{"admin" => admin_params}) do
    admin = Admins.get_admin!(admin_params["id"])

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
