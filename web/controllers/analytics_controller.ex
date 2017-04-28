defmodule What3things.AnalyticsController do
  use What3things.Web, :controller
  alias What3things.{User}

  def index(conn, _params) do
    users = Repo.all(User)

    render conn, "index.html", users: users
  end
end
