defmodule ParkinsonsAndMe.Email do
  use Bamboo.Phoenix, view: ParkinsonsAndMe.EmailView

  def welcome_email(%{user: user, top3services: top3services, uuid: uuid}) do
    base_email()
    |> to(user.email)
    |> assign(:top3services, top3services)
    |> assign(:uuid, uuid)
    |> assign(:user, user)
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
