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

alias What3things.{Service, Quote, Repo}

quotes =
  [ "I’d feel most comfortable if support staff came to see me at home.",
    "I’ll just wait and see what information and support I’m offered.",
    "I want to say what I feel without anyone knowing who I am, but know that someone will still be there listening and supporting me.",
    "I want to find somewhere local where I can meet other people with Parkinson’s and share my experiences.",
    "I don’t want to wait for someone to help me, I want to go out and help myself.",
    "There’s something specific I want to know about Parkinson’s and how it’s going to affect me.",
    "I want to have a private one-to-one quite soon to talk things through",
    "I’m happy chatting on forums and social media.",
    "I want to understand my condition so I can plan for the long term."
  ]
  |> Enum.map(fn(q) -> %{body: q} end)

Repo.insert_all(Quote, quotes)
