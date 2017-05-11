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
    |> from("Parkinson's and Me <web@parkinsons.org.uk>")
    |> put_header("Reply-To", "web@parkinsons.org.uk")
    |> put_layout({ParkinsonsAndMe.LayoutView, :email})
  end
end
