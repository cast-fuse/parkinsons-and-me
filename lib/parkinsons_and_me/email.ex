defmodule ParkinsonsAndMe.Email do
  use Bamboo.Phoenix, view: ParkinsonsAndMe.EmailView

  def welcome_email(%{to: to, top3things: top3things, uuid: uuid, name: name}) do
    base_email()
    |> to(to)
    |> assign(:top3things, top3things)
    |> assign(:uuid, uuid)
    |> assign(:name, name)
    |> subject("Your recommended Parkinson's information and support")
    |> render(:results)
  end

  def base_email do
    new_email()
    |> from("andrew@wearecast.org.uk")
    |> put_html_layout({ParkinsonsAndMe.LayoutView, "email.html"})
  end
end
