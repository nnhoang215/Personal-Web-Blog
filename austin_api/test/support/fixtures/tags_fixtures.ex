defmodule AustinApi.TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AustinApi.Tags` context.
  """

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> AustinApi.Tags.create_tag()

    tag
  end
end
