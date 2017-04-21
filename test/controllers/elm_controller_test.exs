defmodule What3things.ElmControllerTest do
  use What3things.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    page = html_response(conn, 200)
    assert page =~ "<title>What3things</title>"
    assert page =~ "src=\"/js/elm.js"
  end
end
