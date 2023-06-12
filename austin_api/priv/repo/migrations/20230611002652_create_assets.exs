defmodule AustinApi.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :url, :string
      add :caption, :string

      timestamps()
    end
  end
end
