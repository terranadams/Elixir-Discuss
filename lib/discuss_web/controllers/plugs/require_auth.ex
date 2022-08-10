defmodule Discuss.Plugs.RequireAuth do
  import Phoenix.Controller
  import Plug.Conn
  alias DiscussWeb.Router.Helpers, as: Routes


  def init(_params) do

  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      # if a user exists, then return conn. If we return conn, it means 'everything checks out, carry on'
      conn
    else
      # if a user hasn't been assigned, we take our conn object and pass an error to it, then redirect back
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt() # this tells phoenix to stop passing the conn object to the next plug
    end
  end
end
