# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     What3things.Repo.insert!(%What3things.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias What3things.{Service, Quote, Repo, Weight}

quotes =
  ["I’d feel most comfortable if support staff came to see me at home.",
  "I’ll just wait and see what information and support I’m offered.",
  "I want to say what I feel without anyone knowing who I am, but know that someone will still be there listening and supporting me.",
  "I want to find somewhere local where I can meet other people with Parkinson’s and share my experiences.",
  "I don’t want to wait for someone to help me, I want to go out and help myself.",
  "There’s something specific I want to know about Parkinson’s and how it’s going to affect me.",
  "I want to have a private one-to-one quite soon to talk things through",
  "I’m happy chatting on forums and social media.",
  "I want to understand my condition so I can plan for the long term."]
  |> Enum.map(fn(q) -> %{body: q} end)


services =
  ["Peer Support Service",
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
  |> Enum.map(fn(s) -> %{title: s, body: "lorem ipsum", cta: "lorem", url: "www.#{s |> String.replace(" ", "")}.com"} end)

  all_weights =
    [[0,0, 0, 0.5, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0.25, 0, 0.5, 0, 0, 0.25, 0, 0],
    [0.5, 1, 0, 0, 0, 0, 0, 0.5, 0.25, 0, 0, 0],
    [0, 0, 1, 0, 0.25, 0, 0.5, 0, 0, 0, 0, 0],
    [0, 0, 0.25, 0, 0, 0, 0, 0, 0.25, 1, 0.5, 0.5],
    [0.5, 0, 0, 0.5, 0, 0.5, 0, 0.5, 0, 0.25, 0, 1],
    [0.25, 0, 0, 0.25, 0, 0.5, 0, 1, 0, 0, 0, 0],
    [0, 0.75, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0.25, 0.5, 0.5, 0, 0, 0, 0.25, 0.25, 0.5]]
    |> Enum.map(fn(x) -> Enum.map(x, fn(y) -> y * 1.0 end) end)

# Repo.insert_all(Quote, quotes)
# Repo.insert_all(Service, services)

quotes = Repo.all(Quote)
services = Repo.all(Service)

services_weight_zip = for weights <- all_weights do
  services
  |> Enum.map(fn(x) -> %{service_id: x.id} end)
  |> Enum.zip(weights)
end

zip_all =
  quotes
  |> Enum.map(fn(x) -> %{quote_id: x.id} end)
  |> Enum.zip(services_weight_zip)
  |> Enum.map(fn({q, s_weights}) -> Enum.map(s_weights, fn({s, w}) -> %{service_id: s.service_id, quote_id: q.quote_id, weight: w} end) end)
  |> List.flatten()


# Repo.insert_all(Weight, zip_all)
