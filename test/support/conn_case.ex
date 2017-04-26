defmodule What3things.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import Plug.Test

      alias What3things.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import What3things.Router.Helpers

      # The default endpoint for testing
      @endpoint What3things.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(What3things.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(What3things.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  def get_service(title) do
    What3things.Repo.get_by!(What3things.Service, title: title)
  end

  def test_login(conn, admin) do
    conn
    |> Plug.Test.init_test_session(admin_id: admin.id)
    |> What3things.Auth.login(admin)
  end
end
