defmodule What3things.UserControllerTest do
  use What3things.ConnCase, async: true
  alias What3things.{Repo, User}

  @dummy_user %{
    name: "Ivan",
    age_range: "under_forty",
    postcode: "sw99ng",
    email: "ivan@email.com"
  }

  @dummy_user_stringified %{
    "name" => "Ivan",
    "age_range" => "under_forty",
    "postcode" => "sw99ng",
    "email" => "ivan@email.com",
    "email_consent" => false
  }

  describe "create/2" do
    test "Create and responds with a newly created user if attributes are valid" do
      user = %{user: @dummy_user}

      response = build_conn()
      |> post(user_path(build_conn(), :create), user)
      |> json_response(201)

      created_user = Repo.get_by(User, name: "Ivan")

      expected = %{"data" =>
        Map.put(@dummy_user_stringified, "id", created_user.id)
      }

      assert response == expected
    end

    test "If user is already in database, does not create a new one" do
      changeset = User.changeset(%User{}, @dummy_user)
      existing_user = Repo.insert!(changeset)

      response = build_conn()
      |> post(user_path(build_conn(), :create), %{user: @dummy_user})
      |> json_response(200)

      expected = %{"data" =>
        Map.put(@dummy_user_stringified, "id", existing_user.id)
      }

      assert response == expected
    end
  end
end
