defmodule What3things.ElmController do
  use What3things.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
