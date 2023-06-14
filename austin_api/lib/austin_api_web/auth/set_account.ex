defmodule AustinApiWeb.Auth.SetAccount do
  import Plug.Conn
  alias AustinApiWeb.Auth.ErrorResponse
  alias AustinApi.Admins
  
  def init(_options) do
    
  end
  
  def call(conn, _options) do
    if conn.assigns[:account] do
      conn
    else
      admin_id = get_session(conn, :admin_id)
    
      if admin_id == nil, do: raise ErrorResponse.Unauthorized
      
      admin = Admins.get_admin!(admin_id)
      cond do
        admin_id && admin -> assign(conn, :admin, admin)
        true -> assign(conn, :admin, nil)
      end
    end
  end
end