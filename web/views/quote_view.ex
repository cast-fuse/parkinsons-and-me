defmodule What3things.QuoteView do
  use What3things.Web, :view

  def render("quote.json", %{quote: quote_data}) do
    %{id: quote_data.id,
      body: quote_data.body}
  end
end
