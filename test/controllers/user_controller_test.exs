defmodule What3things.UserControllerTest do
  use What3things.ConnCase, async: true
  alias What3things.{Repo, User}

  describe "create/2" do
    test "Create and responds with a newly created user if attributes are valid" do
      user = %{user: %{name: "Ivan", age_range: "under_forty", postcode: "sw99ng", email: "ivan@email.com"}}

      response = build_conn()
      |> post(user_path(build_conn(), :create), user)
      |> json_response(201)

      created_user = Repo.get_by(User, name: "Ivan")

      expected = %{"data" =>
        %{"name" => "Ivan", "age_range" => "under_forty", "postcode" => "sw99ng", "email" => "ivan@email.com", "id" => created_user.id}
      }
      assert response == expected
    end

    test "If user is already in database, does not create a new one" do
      user = %{name: "Ivan", age_range: "under_forty", postcode: "sw99ng", email: "ivan@email.com"}
      changeset = User.changeset(%User{}, user)
      existing_user = Repo.insert!(changeset)

      response = build_conn()
      |> post(user_path(build_conn(), :create), %{user: user})
      |> json_response(200)

      expected = %{"data" =>
      %{"age_range" => "under_forty", "email" => "ivan@email.com", "id" => existing_user.id, "name" => "Ivan", "postcode" => "sw99ng"}}

      assert response == expected
    end
  end
end
