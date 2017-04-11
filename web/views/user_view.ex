defmodule What3things.UserView do
  use What3things.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, What3things.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, What3things.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      age_range: user.age_range,
      postcode: user.postcode,
      email: user.email}
  end
end
