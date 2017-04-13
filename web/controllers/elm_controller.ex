defmodule What3things.ElmController do
  use What3things.Web, :controller
  alias What3things.{Quote, Service, Weight}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def quotes_services_weightings(conn, _params) do
    quotes = Repo.all(Quote)
    services = Repo.all(Service)
    weightings = Repo.all(Weight)

    json conn, %{quotes: quotes, services: services, weightings: weightings}
  end
end
