# this model file was created with 'mix phx.gen.schema Topic topics title:string', which made a 'Topics' context
# this file tells phoenix what the structure of the 'topics' table looks like so it can communicate with it
defmodule Discuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string
    timestamps()
  end
   # model files require a schema (like above) and code for validation (checking data types, etc.)


  @doc false
  def changeset(topic, attrs \\ %{}) do # a changeset is an struct object that holds/records the updates in our db we need to make before they get submitted. The first arg is what the record was, the second is what it needs to be
    # the 'topic' arg is a struct that contains data, reps a record, whether it's a new or prev existing one
    # attrs (params) contain properties we want to update the struct with
    topic
    |> cast(attrs, [:title]) # this function records how we want to update our db with new properties, but checks whether or not those properties are valid
    |> validate_required([:title]) # updates and returns the changeset/struct thing with the new info, and additional data on if the new updates are valid or not
  end
end # with this complete topic model file, we can start using it with our form to input records to our 'topics' table.


# a struct for this model file was created automatically, run iex -S mix and then run 'struct = %Discuss.Topic{}' to see it, which starts empty...
# then run 'params = %{title: "Great JS"}' to make a params object/map to be added to 'struct'...
# then we call our changeset function with both those arguments. 'Discuss.Topic.changeset(struct, params)'...
# changeset is not only a function, it's the name of the new struct that gets returned when we run the line above.
# the thing that gets saved to the db is the changeset struct that gets returned.
