defmodule What3things.WeightController do
  use What3things.Web, :controller
  alias What3things.Weight

  def index(conn, _params) do
    weights =
      Weight
      |> Repo.all()
      |> Repo.preload(:quote)
      |> Repo.preload(:service)

    render conn, "index.html", weights: weights
  end

  def edit(conn, %{"id" => weight_id}) do
    weight =
      Weight
      |> Repo.get(weight_id)
      |> Repo.preload(:quote)
      |> Repo.preload(:service)

    changeset = Weight.changeset(weight)
    IO.inspect changeset
    render conn, "edit.html", changeset: changeset, weight: weight
  end

  def update(conn, %{"id" => weight_id, "weight" => weight}) do
    old_weight = Repo.get(Weight, weight_id)
    changeset = Weight.changeset(old_weight, weight)

    case Repo.update(changeset) do
      {:ok, _weight} ->
        conn
        |> put_flash(:info, "weight updated")
        |> redirect(to: weight_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, weight: old_weight 
    end
  end
end
