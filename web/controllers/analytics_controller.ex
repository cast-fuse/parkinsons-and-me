defmodule What3things.AnalyticsController do
  use What3things.Web, :controller
  alias What3things.{User, Answer}

  def index(conn, %{"users" => "true"}) do
    users = Repo.all(User)
    render conn, "users.html", users: users
  end

  def index(conn, %{"answers" => "true"}) do
    quote_answers = Repo.all(Answer.answer_aggregates)
    render conn, "answers.html", quote_answers: quote_answers
  end

  def index(conn, _params) do
    render conn, "index.html"
  end
end
