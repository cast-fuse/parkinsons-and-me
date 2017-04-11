defmodule What3things.ServiceController do
  use What3things.Web, :controller
  alias What3things.Service

  def index(conn, _params) do
    services = Repo.all(Service)
    render conn, "index.html", services: services
  end
end
