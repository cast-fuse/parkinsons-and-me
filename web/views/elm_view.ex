defmodule What3things.ElmView do
  use What3things.Web, :view
  alias What3things.{QuoteView, ServiceView, WeightView, UserView, AnswerView}

  def render("quotes_services_weightings.json", data) do
    %{data: quotes_services_weightings(data) }
  end

  def render("results.json", %{data: data, user_data: user_data}) do
    all_data = Map.merge(
      quotes_services_weightings(data),
      user_answers(user_data))
    %{data: all_data}
  end

  def user_answers(user_data) do
    %{user: render_one(user_data.user, UserView, "user.json"),
      answers: render_many(user_data.answers, AnswerView, "answer.json")}
  end

  def quotes_services_weightings(data) do
    %{quotes: render_many(data.quotes, QuoteView, "quote.json"),
      services: render_many(data.services, ServiceView, "service.json"),
      weightings: render_many(data.weightings, WeightView, "weight.json")}
  end
end
