defmodule AustinApi.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "assets" do
    field :caption, :string
    field :type, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:type, :url, :caption])
    |> validate_required([:type, :url, :caption])
  end
end
