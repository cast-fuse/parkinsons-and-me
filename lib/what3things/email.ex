defmodule What3things.Email do
  use Bamboo.Phoenix, view: What3things.EmailView

  def welcome_email(%{to: to}) do
    base_email()
    |> to(to)
    |> subject("here are your top 3 things")
    |> render(:results)
  end

  def base_email do
    new_email()
    |> from("andrew@wearecast.org.uk")
    |> put_html_layout({What3things.LayoutView, "email.html"})
  end
end
