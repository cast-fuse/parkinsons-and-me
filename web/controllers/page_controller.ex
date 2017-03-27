defmodule What3things.PageController do
  use What3things.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
