defmodule AustinApi.Admins.Admin do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "admins" do
    field :email, :string
    field :hash_password, :string
    has_many :posts, AustinApi.Posts.Post
    has_many :comments, AustinApi.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:email, :hash_password])
    |> validate_required([:email, :hash_password])
  end
end
