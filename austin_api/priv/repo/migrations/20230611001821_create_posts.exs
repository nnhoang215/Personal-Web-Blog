defmodule AustinApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :subtitle, :string
      add :content, :string
      add :published_at, :date

      timestamps()
    end
  end
end
