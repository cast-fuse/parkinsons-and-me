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

  def results(conn, %{"answer_uuid" => answer_uuid}) do
    answer_set = Answer.get_by_uuid(answer_uuid)
    case Repo.all(answer_set) do
      nil ->
        conn
        |> put_status(:not_found)
        |> render(What3things.ErrorView, "404.json")
      answers ->
        quotes = Repo.all(Quote)
        services = Repo.all(Service)
        weightings = Repo.all(Weight)
        user = Repo.one(User.get_by_answer_uuid(answer_uuid))
        results =
          %{data: %{quotes: quotes, services: services, weightings: weightings},
            user_data: %{user: user, answers: answers}}
        # IO.inspect results
        render conn, "results.json", results
    end
  end
end
