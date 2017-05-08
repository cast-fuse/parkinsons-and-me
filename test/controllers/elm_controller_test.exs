defmodule ParkinsonsAndMe.ElmControllerTest do
  use ParkinsonsAndMe.ConnCase
  alias ParkinsonsAndMe.{DatabaseSeeder, User, AnswerSet, Answer, Quote}

  @user %User{
    name: "Anne Onymous",
    age_range: "fifties",
    postcode: "e82na",
    email: "anne@onymous.com"
  }

  setup do
    Repo.insert!(@user)
    DatabaseSeeder.populate_db()
    submit_answers_for_user("Anne Onymous")
  end

  def submit_answers_for_user(username) do
    user = Repo.get_by(User, name: username)
    quotes = Repo.all(Quote)
    {:ok, answer_set} = Repo.insert(%AnswerSet{user_id: user.id, uuid: "12345678"})
    answers = quotes |> Enum.map(fn(x) -> %{quote_id: x.id, answer_set_id: answer_set.id, answer: true} end)
    Repo.insert_all(Answer, answers)
    :ok
  end

  test "loads resources for the elm app", %{conn: conn} do
    conn = get conn, "/"
    page = html_response(conn, 200)
    assert page =~ "<title>Parkinsons and Me</title>"
    assert page =~ "src=\"/js/elm.js"
  end

  test "loads all quotes services and weightings", %{conn: conn} do
    conn = get conn, "/api/quotes-services-weightings"
    %{"data" =>
      %{"quotes" => quotes,
        "services" => services,
        "weightings" => weightings}} = json_response(conn, 200)
    assert length(quotes) > 0
    assert length(services) > 0
    assert length(weightings) == (length(quotes) * length(services))
  end

  test "loads all the data for the elm app based on an answer uuid", %{conn: conn} do
    conn = get conn, "/api/my-results/12345678"
    %{"data" =>
      %{"quotes" => quotes,
        "services" => _,
        "weightings" => _,
        "user" => user,
        "answers" => answers}} = json_response(conn, 200)
    assert length(answers) == length(quotes)
    assert user["name"] == "Anne Onymous"
  end
end
