defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller # this is the equivilent of doing class inheritance inside Elixir, specifically DiscussWeb's "controller" function, which itself imports other modules
  # this is how we code share, just by adding the line above, we've added a ton of functionality into our controller
  alias DiscussWeb.Router.Helpers, as: Routes

  alias Discuss.Topic
  alias Discuss.Repo
   # if we write 'alias Discuss.Topic' right here, then we are able to shortcut the phrase "Discuss.Topic" to just "Topic" whenever we reference it below...
  #... so the 'struct' variable below could just be "struct = %Topic{}" instead of "%Discuss.Topic{}"

  def index(conn, _params) do
    topics = Repo.all(Topic) # this is our query
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    # the 'conn' struct holds data for the request and the response
    struct = %Topic{} # this struct starts off empty because we don't have data for the form yet.
    params = %{} # this is also empty because we don't have any changes yet. New info will be capturec and added to the struct when the form gets submitted, to be added to the db later
    changeset = Topic.changeset(struct, params) #this is where the changeset starts (still empty), it gets passed to all the pages aquained with topics, this page will add data to it when the form gets submitted, the user then gets redirected to antoher page
    #sum = 1 + 1
    render conn, "new.html", changeset: changeset#, sum: sum ... Lecture 77
  end


  def create(conn, params) do
    # IO.inspect params
    %{"topic" => topic} = params # because the format of the 'params' map is {"x" => "asdf"} instead of {x: "asdf"} , we must pattern match the variable out of it instead of doing dot notation like params.topic
    # again, we can pattern match this variable right in the argument declaration line by replacing "params" with  "%{"topic" => topic}"
    changeset = Topic.changeset(%Topic{}, topic)
    IO.inspect changeset
    # Repo.insert(changeset)
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created") # this shows a quick message to the user one time when the page reloads
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        IO.inspect changeset
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id) # we're finding a specific document from our 'topics' table
    changeset = Topic.changeset(topic) # we're trying to edit a pre-existing record, we pass it to our html doc
    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic) # we're making a changeset out of an existing record, and passing the new changes to it (the topic from the form)
    # changeset = Repo.get(Topic, topic_id) |> Topic.changeset((topic)) # we would use this, but we need to make use of old_topic so we can pass it to the form for the error helper
    case Repo.update(changeset) do # the changeset contains the record ID to update
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
      end
  end

  def delete(conn, params) do
    %{"id" => topic_id} = params
    Repo.get!(Topic, topic_id) |> Repo.delete! # we don't delete by ID, we delete by obtaining the full record's struct and passing it into the delete func
     # adding the '!' aka 'bang', returns an error if anything goes wrong with the delete process (permissions, etc)
    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end

# ********************************* IMPORTANT INFO FOR v1.3 of Phx
# You will need to manually add your model to the following path (note the different use/imports):
# lib/discuss/topic.ex
# defmodule Discuss.Topic do
#   use Ecto.Schema
#   import Ecto.Changeset

#   schema "topics" do
#     field :title, :string
#   end
# end
# In v1.3 you will normally run a different command that will generate the model and migration for you.
# mix phx.gen.schema Topic topics title:string
