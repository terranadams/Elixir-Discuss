defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration
 # this file was generated with 'mix ecto.gen.migration add_users'
 # we executed the migration by running 'mix ecto.migrate'
  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps()
    end
  end
end
