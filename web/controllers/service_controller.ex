defmodule ParkinsonsAndMe.ServiceController do
  use ParkinsonsAndMe.Web, :controller
  alias ParkinsonsAndMe.Service
  plug :authenticate_admin

  def index(conn, _params) do
    services = Repo.all(Service)
    render conn, "index.html", services: services
  end

  def edit(conn, %{"id" => service_id}) do
    service = Repo.get(Service, service_id)
    changeset = Service.changeset(service)

    render conn, "edit.html", changeset: changeset, service: service
  end

  def update(conn, %{"id" => service_id, "service" => service}) do
    old_service = Repo.get(Service, service_id)
    changeset = Service.changeset(old_service, service)

    case Repo.update(changeset) do
      {:ok, _service} ->
        conn
        |> put_flash(:info, "service updated")
        |> redirect(to: service_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, service: old_service
    end
  end
end
