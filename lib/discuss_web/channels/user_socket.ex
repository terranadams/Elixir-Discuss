defmodule DiscussWeb.UserSocket do
  use Phoenix.Socket # this tells the module how to behave like a socket module

  channel "comments:*", Discuss.CommentsChannel # this channel called 'comments' will be managed by our CommentsChannel module
  # the first arg is the name of the channel (like a route in a router file) that a js client will be attaching itself to (like a chatroom)
  # the asterisk is a wildcard (param), think of this whole thing as like an endpoint for our socket implementation, anything that tries to join,
  # ... all traffic should be forwarded to our CommentsChannel module


  transport :websocket, Phoenix.Transports.Websocket #

  def connect(_params, socket) do # this func gets ran anytime a new js client connects to our phx server with a web socket
  # the socket arg is nearly identical to the conn object in the controller side of our app, has everything to do with the incoming...
  # ... request and the outgoing response

    {:ok, socket}
  end


end



# defmodule Discuss.UserSocket do
#   use Phoenix.Socket

#   channel "comments:*", Discuss.CommentsChannel

#   transport :websocket, Phoenix.Transports.WebSocket

#   def connect(%{"token" => token}, socket) do
#     case Phoenix.Token.verify(socket, "key", token) do
#       {:ok, user_id} ->
#         {:ok, assign(socket, :user_id, user_id)}
#       {:error, _error} ->
#         :error
#     end
#   end

#   def id(_socket), do: nil
# end
