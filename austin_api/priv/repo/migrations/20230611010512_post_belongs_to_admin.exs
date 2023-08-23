defmodule AustinApi.Repo.Migrations.PostBelongsToAdmin do
  use Ecto.Migration

  def change do
    alter table (:posts) do
      add :admin_id, references(:admins, type: ) 
    end
  end
end
