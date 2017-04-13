defmodule What3things.ElmController do
  use What3things.Web, :controller
  alias What3things.{Quote, Service, Weight, User, Answer}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def quotes_services_weightings(conn, _params) do
    quotes = Repo.all(Quote)
    services = Repo.all(Service)
    weightings = Repo.all(Weight)

    json conn, %{quotes: quotes, services: services, weightings: weightings}
  end

  def previous_results(conn, %{"answer_id" => answer_id}) do
    quotes = Repo.all(Quote)
    services = Repo.all(Service)
    weightings = Repo.all(Weight)

    case Repo.get(Answer, answer_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(What3things.ErrorView, "404.json")
      answer ->
        user = Repo.get(User, answer.user_id)
        json conn, %{quotes: quotes, services: services, weightings: weightings, user: user, answer: answer}
    end
  end
end
