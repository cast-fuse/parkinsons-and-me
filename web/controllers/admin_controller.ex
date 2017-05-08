defmodule ParkinsonsAndMe.AdminController do
  use ParkinsonsAndMe.Web, :controller
  plug :authenticate_admin

  def index(conn, _params) do
    render conn, "index.html"
  end
end
