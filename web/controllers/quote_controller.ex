defmodule What3things.QuoteController do
  use What3things.Web, :controller
  alias What3things.Quote

  def index(conn, _params) do
    quotes = Repo.all(Quote)
    render conn, "index.html", quotes: quotes
  end
end
