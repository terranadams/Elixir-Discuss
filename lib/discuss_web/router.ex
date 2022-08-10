defmodule DiscussWeb.Router do
  use DiscussWeb, :router

  pipeline :browser do # a pipeline of plugs, these ensures that preprocessing on the request happens before we accept the request itself
    plug :accepts, ["html"] # basically little functions that transform our incoming request / connection object
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DiscussWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Discuss.Plugs.SetUser # this is the plug we made that sets the current user to the conn object
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussWeb do
    pipe_through :browser
<<<<<<< HEAD
    get "/", TopicController, :index
    # when someone requests that endpoint, it runs the "index" function in the "TopicController" module
    get "/topics/new", TopicController, :new
    post "/topics", TopicController, :create
    get "/topics/:id/edit", TopicController, :edit
    put "/topics/:id", TopicController, :update
    delete "/topics/:id", TopicController, :delete
    # resources "/", TopicController
=======
    # get "/", TopicController, :index
    # # when someone requests that endpoint, it runs the "index" function in the "TopicController" module
    # get "/topics/new", TopicController, :new
    # post "/topics", TopicController, :create
    # get "/topics/:id/edit", TopicController, :edit
    # put "/topics/:id", TopicController, :update
    # delete "/topics/:id", TopicController, :delete
    resources "/", TopicController 
>>>>>>> 4435b4f550dcae00d8baba61dd4008a6b2bb2e7f
    # if restful convension is followed, we can remove all the code above and put 'resouces "/", TopicController'
  end

  scope "/auth", DiscussWeb do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request #uberauth is already setup to look at the params object and provider value to decide which strategy to use (in this case, github)
    # "/auth/github"
    get "/:provider/callback", AuthController, :callback
    # "/auth/github/callback"
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DiscussWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
