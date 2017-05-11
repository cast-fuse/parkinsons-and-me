defmodule ParkinsonsAndMe.UserView do
  use ParkinsonsAndMe.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, ParkinsonsAndMe.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      age_range: user.age_range,
      postcode: user.postcode,
      email: user.email,
      email_consent: user.email_consent}
  end
end
