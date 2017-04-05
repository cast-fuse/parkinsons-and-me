defmodule What3things.ServiceController do
  use What3things.Web, :controller
  alias What3things.Service

  def index(conn, _params) do
    services = Repo.all(Service)
    render conn, "index.html", services: services
  end

  def new(conn, _params) do
    changeset = Service.changeset(%Service{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"service" => service}) do
    changeset = Service.changeset(%Service{}, service)

    case Repo.insert(changeset) do
      {:ok, _service} ->
        conn
        |> put_flash(:info, "Service added!")
        |> redirect(to: service_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
