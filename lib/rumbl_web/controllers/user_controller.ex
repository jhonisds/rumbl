defmodule RumblWeb.UserController do
  @moduledoc """
  The User Controller module
  """
  use RumblWeb, :controller

  alias Rumbl.Accounts

  def index(conn, _params) do
    # IO.inspect(conn, label: "[User Controller]")
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    # IO.inspect(conn, label: "[User Controller]")
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end
end
