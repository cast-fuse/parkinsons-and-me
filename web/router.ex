defmodule What3things.Router do
  use What3things.Web, :router
  alias What3things.{Auth, Repo}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :put_layout, {What3things.LayoutView, :admin}
    plug Auth, repo: Repo
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

    get "/", AdminController, :index
    get "/analytics", AnalyticsController, :index

    resources "/login", SessionController, only: [:new, :create, :delete]
    resources "/quotes", QuoteController, only: [:index, :edit, :update]
    resources "/services", ServiceController, only: [:index, :edit, :update]
    resources "/weights", WeightController, only: [:index, :edit, :update]
  end

  # Other scopes may use custom stacks.
  scope "/api", What3things do
    pipe_through :api

    get "/quotes-services-weightings", ElmController, :quotes_services_weightings
    get "/my-results/:answer_uuid", ElmController, :results

    resources "/users", UserController, only: [:create, :update] do
      resources "/answers", AnswerController, only: [:create]
    end
  end
end
