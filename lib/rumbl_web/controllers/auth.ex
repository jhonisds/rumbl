defmodule RumblWeb.Auth do
  @moduledoc """
  Plug for authentication
  """
  import Plug.Conn

  alias Rumbl.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    IO.inspect(user, label: "[Plug Auth login]")

    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end
end
