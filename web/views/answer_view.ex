defmodule ParkinsonsAndMe.AnswerView do
  use ParkinsonsAndMe.Web, :view

  def render("show_answer_set.json", answer_set) do
    %{data: render("answer_set.json", answer_set)}
  end

  def render("show_answers.json", %{answers: answers}) do
    %{data: render_many(answers, ParkinsonsAndMe.AnswerView, "answer.json")}
  end

  def render("answer_set.json", %{answer_set: answer_set}) do
    %{id: answer_set.id,
      user_id: answer_set.user_id,
      uuid: answer_set.uuid}
  end

  def render("answer.json", %{answer: answer}) do
    %{id: answer.id,
      quote_id: answer.quote_id,
      answer: answer.answer}
  end
end
