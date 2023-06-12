defmodule AustinApi.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AustinApi.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        content: "some content",
        published_at: ~D[2023-06-10]
      })
      |> AustinApi.Comments.create_comment()

    comment
  end
end
