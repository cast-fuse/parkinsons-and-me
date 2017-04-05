defmodule What3things.Router do
  use What3things.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :put_layout, {What3things.LayoutView, :admin}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", What3things do
    pipe_through :browser # Use the default browser stack

    get "/", ElmController, :index
  end

  scope "/admin", What3things do
    pipe_through :browser
    pipe_through :admin

    get "/quotes", QuoteController, :index
    get "/quotes/new", QuoteController, :new
    post "/quotes", QuoteController, :create

    get "/services", ServiceController, :index
    get "/services/new", ServiceController, :new
    post "/services", ServiceController, :create

    resources "/weights", WeightController, only: [:index, :update, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", What3things do
  #   pipe_through :api
  # end
end
