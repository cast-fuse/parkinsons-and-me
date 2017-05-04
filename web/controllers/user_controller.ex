defmodule What3things.UserController do
  use What3things.Web, :controller
  alias What3things.{User, Email, Service, Mailer}

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
        |> render(What3things.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => %{"email" => email}, "service_ids" => service_ids, "uuid" => uuid}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, %{email: email})

    case Repo.update(changeset) do
      {:ok, user} ->
        handle_email(%{email: email, service_ids: service_ids, uuid: uuid})
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(What3things.ChangesetView, "error.json", changeset: changeset)
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
        |> render(What3things.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp get_top3things(top3_ids) do
    top3_ids
    |> Service.services_by_id
    |> Repo.all
  end

  def handle_email(%{email: email, service_ids: service_ids, uuid: uuid}) do
    params = %{to: email, top3things: get_top3things(service_ids), uuid: uuid}
    params
    |> Email.welcome_email()
    |> Mailer.deliver_later()
  end
end
