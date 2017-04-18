defmodule What3things.AdminController do
  use What3things.Web, :controller
  plug :authenticate when action in [:index]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def authenticate(conn, _params) do
    if conn.assigns.admin do
      conn
    else
      conn
      |> put_flash(:error, "you must be logged in to see that page")
      |> redirect(to: session_path(conn, :new))
      |> halt()
    end
  end
end
