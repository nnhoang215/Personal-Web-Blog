defmodule AustinApi.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :content, :string
    field :published_at, :date
    field :subtitle, :string
    field :title, :string
    has_many :tags, AustinApi.Tags.Tag
    belongs_to :admins, AustinApi.Admins.Admin

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :subtitle, :content, :published_at])
    |> validate_required([:title, :subtitle, :content, :published_at])
  end
end
