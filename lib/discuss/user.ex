defmodule Discuss.User do # I made this by running 'mix phx.gen.schema User users' after executing the new migration for the users table
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, Discuss.Topic # "hey, this user may have many topics, each of them should be an instance of Discuss.Topic"
    # 'iex -S mix' > 'Discuss.Repo.Get(Discuss.User, 1)' > returns struct of that specific record by the ID from that specific table
    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
