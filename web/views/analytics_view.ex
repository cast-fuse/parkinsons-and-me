defmodule ParkinsonsAndMe.AnalyticsView do
  use ParkinsonsAndMe.Web, :view

  def render_consent(consent) do
    case consent do
      true -> "Yes"
      false -> "No"
    end
  end
end
