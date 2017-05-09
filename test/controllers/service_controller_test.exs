defmodule ParkinsonsAndMe.ServiceControllerTest do
  use ParkinsonsAndMe.ConnCase
  import ParkinsonsAndMe.ConnCase
  alias ParkinsonsAndMe.{Admin, DatabaseSeeder}

  @admin %Admin{
    id: 123456,
    user_name: "a@b.com",
    password_hash: Comeonin.Bcrypt.hashpwsalt("password")
  }

  setup do
    DatabaseSeeder.populate_db()
    Repo.insert!(@admin)
    {:ok, conn: build_conn() |> test_login(@admin)}
  end

  test "renders a list of all existing services", %{conn: conn} do
    conn = get conn, service_path(conn, :index)
    assert html_response(conn, 200) =~ "Join us on Facebook"
    assert html_response(conn, 200) =~ "Call our confidential helpline"
  end

  test "can see a form to edit an existing service", %{conn: conn} do
    service = get_service("Join us on Facebook")
    conn = get conn, service_path(conn, :edit, service.id)
    assert html_response(conn, 200) =~ "Join us on Facebook"
    assert html_response(conn, 200) =~ "</textarea>"
    assert html_response(conn, 200) =~ "</form>"
  end

  test "can edit an existing service", %{conn: conn} do
    service = get_service("Join us on Facebook")
    changes = %{"title" => "Another Service"}
    index_path = service_path(conn, :index)

    conn = patch conn, service_path(conn, :update, service.id), %{"id" => service.id, "service" => changes}
    assert redirected_to(conn, 302) =~ index_path

    conn = get conn, index_path
    assert html_response(conn, 200) =~ "Another Service"
  end
end
