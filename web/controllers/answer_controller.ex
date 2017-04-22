defmodule What3things.AnswerController do
  use What3things.Web, :controller
  alias What3things.{Answer, AnswerSet}
  alias Ecto.Multi

  def create(conn, %{"answer" => %{"answers" => answers}, "user_id" => user_id}) do
    uuid = Ecto.UUID.generate() |> String.slice(0, 8)
    answer_set_changeset = AnswerSet.changeset(%AnswerSet{}, %{uuid: uuid, user_id: user_id})
    answer_set =
      Multi.new
      |> Multi.insert(:create_answer_set, answer_set_changeset)
      |> Multi.run(:add_answers, fn(x) -> insert_answers(x.create_answer_set.id, answers) end)
      |> Repo.transaction

    case answer_set do
      {:ok, answer} ->
        conn
        |> put_status(:created)
        |> render("show_answer_set.json", answer_set: answer.create_answer_set)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(What3things.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp insert_answers(answer_set_id, answers) do
    formatted = format_answers(answer_set_id, answers)
    case Repo.insert_all(Answer, formatted) do
      {n, nil} ->
        {:ok, {n, nil}}
      err ->
        {:error, err}
    end
  end

  defp format_answers(answer_set_id, answers) do
    answers
    |> Map.to_list
    |> Enum.map(&construct_answer(&1, answer_set_id))
  end

  defp construct_answer({quote_id, answer}, answer_set_id) do
    %{quote_id: String.to_integer(quote_id),
      answer_set_id: answer_set_id,
      answer: answer}
  end
end
