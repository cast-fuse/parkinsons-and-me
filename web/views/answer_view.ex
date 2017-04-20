defmodule What3things.AnswerView do
  use What3things.Web, :view

  def render("show.json", %{answer: answer}) do
    %{data: render_one(answer, What3things.AnswerView, "answer.json")}
  end

  def render("answer.json", %{answer: answer}) do
    %{id: answer.id,
      answers: answer.answers,
      user_id: answer.user_id,
      uuid: answer.uuid}
  end
end
