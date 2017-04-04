defmodule What3things.LayoutView do
  use What3things.Web, :view

  def index(conn, _params) do
    render conn, "app.html"
  end

  def admin(conn, _params) do
    render conn, "admin.html"
  end
end
