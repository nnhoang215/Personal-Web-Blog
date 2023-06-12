defmodule AustinApi.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AustinApi.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        published_at: ~D[2023-06-10],
        subtitle: "some subtitle",
        title: "some title"
      })
      |> AustinApi.Posts.create_post()

    post
  end
end
