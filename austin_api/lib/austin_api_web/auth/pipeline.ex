defmodule AustinApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :austin_api,
  module: AustinApiWeb.Auth.Guardian,
  error_handler: AustinApiWeb.Auth.GuardianErrorHandler
  
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource 
end