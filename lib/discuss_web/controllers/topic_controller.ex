defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller # this is the equivilent of doing class inheritance inside Elixir, specifically DiscussWeb's "controller" function, which itself imports other modules
  # this is how we code share, just by adding the line above, we've added a ton of functionality into our controller
  def new(conn, params) do
    # the 'conn' struct holds data for the request and the response.

    # if we write 'alias Discuss.Topic' right here, then we are able to shortcut the phrase "Discuss.Topic" to just "Topic" whenever we reference it below...
    #... so the 'struct' variable below could just be "struct = %Topic{}"

    struct = %Discuss.Topic{} # this struct starts off empty because we don't have data for the form yet.
    params = %{} # this is also empty because we don't have any changes yet.
    changeset = Discuss.Topic.changeset(struct, params)

    render conn, "new.html"
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
