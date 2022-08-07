defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration
# this migration file was created with "mix ecto.gen.migration add_topics".
# we're making a SQL table :)
# this is called a database migration, meaning this function generated alters the structure of the db (add new columns, etc)
  def change do
    create table(:topics) do
      add :title, :string
      timestamps()
    end # this is a set of instructions being passed to postgres by phoenix saying "create a new table called 'topics' with a 'title' column string type
  end
end
# The purpose of this migration is to tell our postgres database what the table structure needs to look like
# we can now run this migration by executing "mix ecto.migrate"
# we just added a new table into our db
## /opt/homebrew/var/postgres ** this is my db location incase the future me needs it**
