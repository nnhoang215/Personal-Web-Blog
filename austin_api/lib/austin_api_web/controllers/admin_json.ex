defmodule AustinApiWeb.AdminJSON do
  alias AustinApi.Admins.Admin

  @doc """
  Renders a list of admins.
  """
  def index(%{admins: admins}) do
    %{data: for(admin <- admins, do: data(admin))}
  end

  @doc """
  Renders a single admin.
  """
  def show(%{admin: admin}) do
    %{data: data(admin)}
  end

  defp data(%Admin{} = admin) do
    %{
      id: admin.id,
      email: admin.email,
      hash_password: admin.hash_password,
      inserted_at: admin.inserted_at #testing only
    }
  end
  
  def admin_token(%{admin: admin, token: token}) do
    %{
      id: admin.id,
      email: admin.email,
      token: token
    }
  end
end
