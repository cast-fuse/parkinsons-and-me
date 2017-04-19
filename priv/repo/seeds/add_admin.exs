alias What3things.{Repo, Admin}

changeset = Admin.changeset(%Admin{}, %{user_name: "admin", password_hash: "cast-fuse"})

Repo.insert!(changeset)
