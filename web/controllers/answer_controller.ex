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
      |> Multi.run(:add_answers, &insert_answers(answers, &1.create_answer_set.id))
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

  defp insert_answers(answers, answer_set_id) do
    formatted = answers |> Enum.map(&add_set_id(&1, answer_set_id))
    case Repo.insert_all(Answer, formatted) do
      {n, nil} ->
        {:ok, {n, nil}}
      err ->
        {:error, err}
    end
  end

  defp add_set_id(%{"quote_id" => quote_id, "answer" => answer}, answer_set_id) do
    %{quote_id: quote_id,
      answer_set_id: answer_set_id,
      answer: answer}
  end
end
