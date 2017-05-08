defmodule ParkinsonsAndMe.Email do
  use Bamboo.Phoenix, view: ParkinsonsAndMe.EmailView

  def welcome_email(%{to: to, top3services: top3services, uuid: uuid, name: name}) do
    base_email()
    |> to(to)
    |> assign(:top3services, top3services)
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
