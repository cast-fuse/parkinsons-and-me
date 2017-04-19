defmodule What3things.SessionController do
  use What3things.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"user_name" => user, "password" => pass}}) do
    case What3things.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "logged in")
        |> redirect(to: admin_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "invalid username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> What3things.Auth.logout()
    |> redirect(to: session_path(conn, :new))
  end
end
