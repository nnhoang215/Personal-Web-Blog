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
    |> put_password_hash()
    # TODO: need more validation for email eg: format, length, unique
  end
  
  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset) do
    change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
  end
  
  defp put_password_hash(changeset), do: changeset
end
