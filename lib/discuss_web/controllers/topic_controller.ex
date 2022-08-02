defmodule Discuss.TopicController do
  use DiscussWeb, :controller # this is the equivilent of doing class inheritance inside Elixir, specifically DiscussWeb's "controller" function, which itself imports other modules
  # this is how we code share, just by adding the line above, we've added a ton of functionality into our controller
  def new(conn, _params) do
    # the 'conn' struct holds data for the request and the response.
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
