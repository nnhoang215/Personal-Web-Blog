defmodule AustinApi.Repo.Migrations.CommentBelongsToPost do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :post_id, references(:posts, type: :binary_id)  
    end
  end
end
