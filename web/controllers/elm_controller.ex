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

    render conn, "quotes_services_weightings.json", %{quotes: quotes, services: services, weightings: weightings}
  end

  def results(conn, %{"answer_id" => answer_id}) do
    case Repo.get(Answer, answer_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(What3things.ErrorView, "404.json")
      answers ->
        quotes = Repo.all(Quote)
        services = Repo.all(Service)
        weightings = Repo.all(Weight)
        user = Repo.get(User, answers.user_id)
        results =
          %{data: %{quotes: quotes, services: services, weightings: weightings},
            user_data: %{user: user, answers: answers}}
        render conn, "results.json", results
    end
  end
end
