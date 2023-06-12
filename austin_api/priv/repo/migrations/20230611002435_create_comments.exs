defmodule AustinApi.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string
      add :published_at, :date
      # add :post_id, references(:posts, on_delete: :nothing, type: :binary_id)
      # add :admin_id, references(:admins, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    # create index(:comments, [:post_id])
    # create index(:comments, [:admin_id])
  end
end
