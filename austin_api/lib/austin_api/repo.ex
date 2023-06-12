defmodule AustinApi.Repo do
  use Ecto.Repo,
    otp_app: :austin_api,
    adapter: Ecto.Adapters.Postgres
end
