defmodule AustinApiWeb.DefaultController do
  use AustinApiWeb, :controller
  
  def index(conn, _params) do
    text conn, "Austin API is running - #{Mix.env}"
  end
end