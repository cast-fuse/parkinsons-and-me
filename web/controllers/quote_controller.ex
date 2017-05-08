defmodule ParkinsonsAndMe.QuoteController do
  use ParkinsonsAndMe.Web, :controller
  alias ParkinsonsAndMe.Quote
  plug :authenticate_admin

  def index(conn, _params) do
    quotes =
      Quote
      |> Quote.in_order
      |> Repo.all
    render conn, "index.html", quotes: quotes
  end

  def edit(conn, %{"id" => quote_id}) do
    user_quote = Repo.get(Quote, quote_id)
    changeset = Quote.changeset(user_quote)

    render conn, "edit.html", changeset: changeset, quote: user_quote
  end

  def update(conn, %{"id" => quote_id, "quote" => user_quote}) do
    old_quote = Repo.get(Quote, quote_id)
    changeset = Quote.changeset(old_quote, user_quote)

    case Repo.update(changeset) do
      {:ok, _quote} ->
        conn
        |> put_flash(:info, "quote updated")
        |> redirect(to: quote_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, quote: old_quote
    end
  end
end
