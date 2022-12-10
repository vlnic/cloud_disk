defmodule CloudDisk.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :public_name, :string
      add :path, :string
      add :map, :map
      add :user_id, references(:users)

      timestamps()
    end
  end
end
