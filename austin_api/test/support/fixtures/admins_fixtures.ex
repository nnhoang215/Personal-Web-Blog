defmodule AustinApi.AdminsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AustinApi.Admins` context.
  """

  @doc """
  Generate a admin.
  """
  def admin_fixture(attrs \\ %{}) do
    {:ok, admin} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hash_password: "some hash_password"
      })
      |> AustinApi.Admins.create_admin()

    admin
  end
end
