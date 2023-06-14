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
    plug :fetch_session # this is to fetch the session
  end
  
  pipeline :auth do
    plug AustinApiWeb.Auth.Pipeline
    plug AustinApiWeb.Auth.SetAdmin
  end

  scope "/api", AustinApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/admins/create", AdminController, :create
    post "/admins/sign_in", AdminController, :sign_in
    get "/get_account", AdminController, :index # testing only
  end
  
  scope "/api", AustinApiWeb do
    pipe_through [:api, :auth] #anything that's called here will have to run through the pipeline in order to run
    get "/admins/by_id/:id", AdminController, :show
  end
end
