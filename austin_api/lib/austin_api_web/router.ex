defmodule AustinApiWeb.Router do
  use AustinApiWeb, :router
  use Plug.ErrorHandler
  
  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end
  
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AustinApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/admins/create", AdminController, :create
    post "/admins/sign_in", AdminController, :sign_in
    get "/get_account", AdminController, :index # testing only
  end
end
