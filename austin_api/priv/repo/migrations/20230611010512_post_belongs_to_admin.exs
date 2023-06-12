defmodule AustinApi.Repo.Migrations.PostBelongsToAdmin do
  use Ecto.Migration

  def change do
    alter table (:posts) do
      add :admin_id, references(:admins, type: :binary_id) 
    end
  end
end
