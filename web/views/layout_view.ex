defmodule ParkinsonsAndMe.LayoutView do
  use ParkinsonsAndMe.Web, :view

  def ga_code do
    case System.get_env("STAGING") do
      "true" -> System.get_env("STAGING_GA")
      _      -> System.get_env("PRODUCTION_GA")
    end
  end
end
