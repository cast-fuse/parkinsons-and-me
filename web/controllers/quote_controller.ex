defmodule What3things.QuoteController do
  use What3things.Web, :controller
  alias What3things.Quote

  def index(conn, _params) do
    quotes = Repo.all(Quote)
    render conn, "index.html", quotes: quotes
  end

  def new(conn, _params) do
    changeset = Quote.changeset(%Quote{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"quote" => quote_data}) do
    IO.inspect quote_data
    changeset = Quote.changeset(%Quote{}, quote_data)

    case Repo.insert(changeset) do
      {:ok, _quote} ->
        conn
        |> put_flash(:info, "Quote created!")
        |> redirect(to: quote_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
