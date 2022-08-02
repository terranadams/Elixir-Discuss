# this model file was created with 'mix phx.gen.schema Topic topics title:string', which made a 'Topics' context.
# it interacts with our 'topics' table in the db, tells phoenix what to expect db shape wise
defmodule Discuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string
# "hey postgres, this model file maps up to your 'topics' table"
    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
