defmodule What3things.ServiceController do
  use What3things.Web, :controller
  alias What3things.Service

  def index(conn, _params) do
    services = Repo.all(Service)
    render conn, "index.html", services: services
  end

  def edit(conn, %{"id" => service_id}) do
    service = Repo.get(Service, service_id)
    changeset = Service.changeset(service)

    render conn, "edit.html", changeset: changeset, service: service
  end
end
