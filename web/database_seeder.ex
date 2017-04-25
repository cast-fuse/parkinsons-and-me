defmodule What3things.DatabaseSeeder do
  alias What3things.{Service, Quote, Repo, Weight}
  alias Ecto.Multi
  import Ecto.Query

  @quotes_list ["I’d feel most comfortable if support staff came to see me at home.",
    "I’ll just wait and see what information and support I’m offered.",
    "I want to say what I feel without anyone knowing who I am, but know that someone will still be there listening and supporting me.",
    "I want to find somewhere local where I can meet other people with Parkinson’s and share my experiences.",
    "I don’t want to wait for someone to help me, I want to go out and help myself.",
    "There’s something specific I want to know about Parkinson’s and how it’s going to affect me.",
    "I want to have a private one-to-one quite soon to talk things through",
    "I’m happy chatting on forums and social media.",
    "I want to understand my condition so I can plan for the long term."]

  @services_list ["Peer Support Service",
    "Forum",
    "Groups",
    "Parkinson's Nurse",
    "Self-management programme",
    "Parkinson's Local Advisor",
    "First Steps",
    "Helpline",
    "Facebook",
    "Newly diagnosed landing page",
    "Early onset web page",
    "Publications"]

  @weights_list [[0,0, 0, 0.5, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0.25, 0, 0.5, 0, 0, 0.25, 0, 0],
    [0.5, 1, 0, 0, 0, 0, 0, 0.5, 0.25, 0, 0, 0],
    [0, 0, 1, 0, 0.25, 0, 0.5, 0, 0, 0, 0, 0],
    [0, 0, 0.25, 0, 0, 0, 0, 0, 0.25, 1, 0.5, 0.5],
    [0.5, 0, 0, 0.5, 0, 0.5, 0, 0.5, 0, 0.25, 0, 1],
    [0.25, 0, 0, 0.25, 0, 0.5, 0, 1, 0, 0, 0, 0],
    [0, 0.75, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0.25, 0.5, 0.5, 0, 0, 0, 0.25, 0.25, 0.5]]

  defp make_quotes do
    @quotes_list |> Enum.map(&make_quote/1)
  end

  def make_services do
    @services_list |> Enum.map(&make_service/1)
  end

  def make_quote(q) do
    %{body: q}
  end

  def make_service(s) do
    %{title: s,
      body: "lorem ipsum",
      cta: "lorem",
      url: "www.#{s |> String.replace(" ", "")}.com"}
  end

  def make_weight(q_id, s_id, w) do
    %{quote_id: q_id,
      service_id: s_id,
      weight: w * 1.0}
  end

  def formated_weights do
    @weights_list |> Enum.map(fn(x) -> Enum.map(x, fn(y) -> y * 1.0 end) end)
  end

  def zip_service_weights(services) do
    for weights <- formated_weights() do
      services
      |> Enum.map(fn(x) -> %{service_id: x.id} end)
      |> Enum.zip(weights)
    end
  end

  def make_weights(quotes, services) do
    quotes
    |> Enum.map(fn(x) -> %{quote_id: x.id} end)
    |> Enum.zip(zip_service_weights(services))
    |> Enum.map(fn({q, s_weights}) -> Enum.map(s_weights, fn({s, w}) -> %{service_id: s.service_id, quote_id: q.quote_id, weight: w} end) end)
    |> List.flatten()
  end

  defp remove_service_query(title) do
    from s in Service, where: s.title == ^title
  end

  defp attach_empty_weights(multi) do
    q_id = multi.add_extra_quote.id
    services = Repo.all(Service)
    weights = Enum.map(services, fn(x) -> make_weight(q_id, x.id, 0) end)

    case Repo.insert_all(Weight, weights) do
      {n, nil} ->
        {:ok, {n, nil}}
      err ->
        {:error, {:add_weights_error, err}}
    end
  end

  defp add_weights(_multi) do
    quotes = Repo.all(Quote)
    services = Repo.all(Service)
    weights = make_weights(quotes, services)

    case Repo.insert_all(Weight, weights) do
      {n, nil}
        -> {:ok, {n, nil}}
      err
        -> {:error, {:add_weights_error, err}}
    end
  end

  def flush_db do
    Multi.new
    |> Multi.delete_all(:delete_weights, Weight)
    |> Multi.delete_all(:delete_services, Service)
    |> Multi.delete_all(:delete_quotes, Quote)
  end

  def populate_db do
    flush_db()
    |> Multi.insert_all(:add_quotes, Quote, make_quotes())
    |> Multi.insert_all(:add_services, Service, make_services())
    |> Multi.delete_all(:remove_service, remove_service_query("First Steps"))
    |> Multi.run(:add_weights, &add_weights/1)
    |> Multi.insert(:add_extra_quote, Quote.changeset(%Quote{}, make_quote("Claires quote")))
    |> Multi.run(:add_empty_weights, &attach_empty_weights/1)
    |> Repo.transaction
  end
end
