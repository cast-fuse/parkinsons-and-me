defmodule ParkinsonsAndMe.QuoteView do
  use ParkinsonsAndMe.Web, :view

  def render("quote.json", %{quote: quote_data}) do
    %{id: quote_data.id,
      body: quote_data.body}
  end
end
