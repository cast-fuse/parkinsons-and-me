defmodule What3things.PageControllerTest do
  use What3things.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "What3things"
  end
end
