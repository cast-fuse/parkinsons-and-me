defmodule What3things.ServiceControllerTest do
  use What3things.ConnCase
  alias What3things.{Service, Admin, Auth}

  @services [
    %{title: "service 1",
      body: "service 1",
      cta: "service 1",
      url: "www.service1.com",
      early_onset: false, shortcode: "service_1"},
    %{title: "service 2",
      body: "service 2",
      cta: "service 2",
      url: "www.service2.com",
      early_onset: false, shortcode: "service_2"}
  ]

  @admin %Admin{
    id: 123456,
    user_name: "a@b.com",
    password_hash: Comeonin.Bcrypt.hashpwsalt("password")
  }

  defp login_conn do
    build_conn()
      |> init_test_session(admin_id: 123456)
      |> Auth.login(@admin)
  end

  def get_service(title) do
    Repo.get_by!(Service, title: title)
  end

  setup do
    Repo.insert_all(Service, @services)
    Repo.insert!(@admin)
    {:ok, conn: login_conn()}
  end

  test "renders a list of all existing services", %{conn: conn} do
    conn = get conn, service_path(conn, :index)
    assert html_response(conn, 200) =~ "service 2"
    assert html_response(conn, 200) =~ "service 1"
  end

  test "can see a form to edit an existing service", %{conn: conn} do
    service = get_service("service 2")
    conn = get conn, service_path(conn, :edit, service.id)
    assert html_response(conn, 200) =~ "service 2"
    assert html_response(conn, 200) =~ "</textarea>"
    assert html_response(conn, 200) =~ "</form>"
  end

  test "can edit an existing service", %{conn: conn} do
    service = get_service("service 2")
    changes = %{"title" => "service 3"}
    index_path = service_path(conn, :index)

    conn = patch conn, service_path(conn, :update, service.id), %{"id" => service.id, "service" => changes}
    assert redirected_to(conn, 302) =~ index_path

    conn = get conn, index_path
    assert html_response(conn, 200) =~ "service 3"
  end
end
