defmodule Discuss.Plugs.SetUser do
  # the goal of this plug is to look into the connection and grab the userID out of the session fetch the user...
  #... out of the db, and do a tiny transform of the connection object and set the user model on that connection object
  #...so that the next plugs will have access to it
  import Plug.Conn
  import Phoenix.Controller
  alias Discuss.Repo
  alias Discuss.User

  # the point of this plug is to check the conn object for a userID, if there is, we retrieve it from the db

  def init(_params) do #this gets called only once on initialization

  end

  def call(conn, _params) do # this func gets called any time a request comes through our pipeline
    # the second 'params' arg is whatever gets returned from the 'init' func above. Since there's no initialization, the arg contatins nothing
    user_id = get_session(conn, :user_id) # checking if this :user_id exists in the session, so we set it as the user below

    cond do # lecture 108
      user = user_id && Repo.get(User, user_id) -> # two birds w/ one stone here, assign a 'user' variable (the struct from the Repo call) AND getting a truthy statement out of the condition
        assign(conn, :user, user) # conn.assigns.user => user struct. Now all the next plugs will have access to the struct in that conn.assigns.user property
      true ->
        assign(conn, :user, nil) # either a user is signed in, or is not.
        # SIDE NOTE, the function that assigns the user is 'assign/3', but the property in conn is conn.assigns (plural) to see it
    end
  end
end
