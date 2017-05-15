defmodule ParkinsonsAndMe.UserController do
  use ParkinsonsAndMe.Web, :controller
  alias ParkinsonsAndMe.{User, Email, Service, Mailer}

  def create(conn, %{"user" => user_params}) do
    %{"name" => name,
      "postcode" => postcode,
      "age_range" => age_range} = user_params

    user_query = User.get_existing({ name, postcode, age_range })
    existing_user = Repo.one(user_query)

    user_params = Map.merge(user_params, %{"email_consent" => false})
    changeset = User.changeset(%User{}, user_params)

    case existing_user do
      nil ->
        conn
        |> create_user(changeset)
      user ->
        conn
        |> render("show.json", user: user)
    end
  end

  defp create_user(conn, changeset) do
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ParkinsonsAndMe.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => %{"email" => email}, "service_ids" => service_ids, "uuid" => uuid}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, %{email: email})

    case Repo.update(changeset) do
      {:ok, user} ->
        handle_email(%{user: user, service_ids: service_ids, uuid: uuid})
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ParkinsonsAndMe.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => %{"email_consent" => email_consent}}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, %{email_consent: email_consent})

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ParkinsonsAndMe.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)
    conn
    |> redirect(to: analytics_path(conn, :index, users: true))
  end

  def handle_email(%{user: user, service_ids: service_ids, uuid: uuid}) do
    params = %{user: user, top3services: top3services(service_ids, user.postcode), uuid: uuid}
    params
    |> Email.welcome_email()
    |> Mailer.deliver_now()
  end

  def top3services(top3_ids, postcode) do
    top3_ids = format_ids top3_ids

    top3_ids
    |> Service.services_by_id
    |> Repo.all
    |> Enum.into(%{})
    |> sort_top3_services(top3_ids)
    |> alter_location_based_urls(postcode)
  end

  defp format_ids(ids) do
    if is_list(ids) do ids else ids_to_list(ids)  end
  end

  defp ids_to_list(ids) do
    ids
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp sort_top3_services(top3services, top3_ids) do
    Enum.map(top3_ids, fn x -> top3services[x] end)
  end

  defp alter_location_based_urls(top3services, postcode) do
    Enum.map(top3services, &add_postcode(&1, postcode))
  end

  defp add_postcode(service, postcode) do
    if service.location_based_url do
      %{service | url: service.url <> postcode}
    else
      service
    end
  end
end
