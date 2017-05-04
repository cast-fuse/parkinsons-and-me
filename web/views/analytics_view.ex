defmodule What3things.AnalyticsView do
  use What3things.Web, :view

  def render_consent(consent) do
    case consent do
      true -> "Yes"
      false -> "No"
    end
  end
end
