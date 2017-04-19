import Ecto.Query
alias What3things.{Weight, Service}

service_to_remove = "First Steps"

q = from w in Weight,
    join: s in Service,
    on: w.service_id == s.id,
    where: s.title == ^service_to_remove

Repo.delete_all(q)
Repo.get_by(Service, title: service_to_remove) |> Repo.delete
