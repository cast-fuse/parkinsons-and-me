defmodule ParkinsonsAndMe.ServiceView do
  use ParkinsonsAndMe.Web, :view

  def render("service.json", %{service: service}) do
    %{id: service.id,
      title: service.title,
      body: service.body,
      cta: service.cta,
      url: service.url,
      early_onset: service.early_onset,
      location_based_url: service.location_based_url}
  end

  def order_services(services) do
    services
    |> Enum.sort_by(fn(x) -> x.id end)
  end
end
