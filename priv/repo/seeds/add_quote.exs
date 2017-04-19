alias What3things.{Service, Quote, Repo, Weight}

user_quote = Quote.changeset(%Quote{}, %{body: "Claire's new quote"})

case Repo.insert(user_quote) do
  {:ok, user_quote} ->
    service_quote_pairs = Repo.all(Service)
      |> Enum.map(fn x -> %{ quote_id: user_quote.id, service_id: x.id, weight: 0.0} end)

    Repo.insert_all(Weight, service_quote_pairs)
  {:error, _} ->
    IO.puts "something went wrong"
end
