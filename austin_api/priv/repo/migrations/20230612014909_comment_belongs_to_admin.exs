defmodule AustinApi.Repo.Migrations.CommentBelongsToAdmin do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :admin_id, references(:admins, type: :binary_id)
    end
  end
end
