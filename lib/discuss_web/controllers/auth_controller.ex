defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth # this is a library that does a lot of OAuth heavy lifting for us once we set it up, we added it in mix.exs and configured it in config/config.exs
  alias DiscussWeb.Router.Helpers, as: Routes
  alias Discuss.User
  alias Discuss.Repo


  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do # the 'assigns' property of the conn object is used for assigning data that we want to carry along inside our connection
    # IO.inspect auth
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id) # any signed in user should have some data in their cookies tied to our domain with their id cuz of this line
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do # this is intended to be a stand alone helper function for the auth controller
    # the goal of this func is to check for any pre-existing users that are similar to a new one being added
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset) # this is how we add records to our db
      user ->
        {:ok, user}
    end
  end
end
