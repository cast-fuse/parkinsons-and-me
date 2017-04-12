defmodule What3things.ServiceView do
  use What3things.Web, :view

  def order_services(services) do
    services
    |> Enum.sort_by(fn(x) -> x.id end)
  end
end
