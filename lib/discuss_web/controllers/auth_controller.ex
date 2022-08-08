defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth # this is a library that does a lot of oauth heavy lifting for us once we set it up


  def callback(conn, params) do
    
  end
end
