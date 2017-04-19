defmodule What3things.AnswerController do
  use What3things.Web, :controller
  alias What3things.Answer

  def create(conn, %{"answer" => answer_params, "user_id" => user_id}) do
    uuid = Ecto.UUID.generate() |> String.slice(0, 8)
    changeset = Answer.changeset(%Answer{}, Map.merge(answer_params, %{"user_id" => user_id, "uuid" => uuid}))

    case Repo.insert(changeset) do
      {:ok, answer} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_answer_path(conn, :show, user_id, answer))
        |> render("show.json", answer: answer)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(What3things.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Repo.get!(Answer, id)
    changeset = Answer.changeset(answer, answer_params)

    case Repo.update(changeset) do
      {:ok, answer} ->
        render(conn, "show.json", answer: answer)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(What3things.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
