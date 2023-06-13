defmodule AustinApiWeb.Router do
  use AustinApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AustinApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/admins/create", AdminController, :create
    get "/get_account", AdminController, :index # testing only
  end
end
