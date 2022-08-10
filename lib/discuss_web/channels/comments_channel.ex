defmodule Discuss.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.Repo
  alias Discuss.{Topic, Comment}

# this is a callback, a func that is automatically called at some point for us.
  def join(name, _params, socket) do # join is called whenever a js client attempts to join this channel
  # the first arg is the "route" of sorts (comments:*), second arg is auth_msg, and the third arg is the actual socket object...
  #... the thing that reps the entire life cycle of the socket
  IO.puts "++++++"
  IO.puts(name)
  {:ok, %{}, socket}
  end

  def handle_in() do

  end
end






# defmodule Discuss.CommentsChannel do
#   use DiscussWeb, :channel


#   def join("comments:" <> topic_id, _params, socket) do
#     topic_id = String.to_integer(topic_id)
#     topic = Topic
#       |> Repo.get(topic_id)
#       |> Repo.preload(comments: [:user])

#     {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
#   end

#   def handle_in(name, %{"content" => content}, socket) do
#     topic = socket.assigns.topic
#     user_id = socket.assigns.user_id

#     changeset = topic
#       |> Ecto.build_assoc(:comments, user_id: user_id)
#       |> Comment.changeset(%{content: content})

#     case Repo.insert(changeset) do
#       {:ok, comment} ->
#         broadcast!(socket, "comments:#{socket.assigns.topic.id}:new",
#           %{comment: comment}
#         )
#         {:reply, :ok, socket}
#       {:error, _reason} ->
#         {:reply, {:error, %{errors: changeset}}, socket}
#     end
#   end
# end
