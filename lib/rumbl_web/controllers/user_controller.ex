defmodule RumblWeb.UserController do
  @moduledoc """
  The User Controller module
  """
  use RumblWeb, :controller

  alias Rumbl.Accounts

  def index(conn, _params) do
    IO.inspect(conn, label: "[User Controller]")
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end
end
