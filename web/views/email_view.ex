defmodule ParkinsonsAndMe.EmailView do
  use ParkinsonsAndMe.Web, :view

  def strip_iframe(body) do
    if body =~ "iframe" do
      body
      |> String.split("<iframe")
      |> List.first
    else
      body
    end
  end
end
