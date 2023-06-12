defmodule AustinApi.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :content, :string
    field :published_at, :date
    belongs_to :posts, AustinApi.Posts.Post
    belongs_to :admins, AustinApi.Admins.Admin

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :published_at])
    |> validate_required([:content, :published_at])
  end
end
