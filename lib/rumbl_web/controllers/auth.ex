defmodule RumblWeb.Auth do
  @moduledoc """
  Plug for authentication
  """
  import Plug.Conn
  import Phoenix.Controller

  alias Rumbl.Accounts
  alias RumblWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    # IO.inspect(user, label: "[Plug Auth login]")

    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    # IO.inspect(conn, label: "[IO - logout]")
    configure_session(conn, drop: true)
  end

  def authenticate_user(conn, _opts) do
    # IO.inspect(conn, label: "[IO - authenticate_user]")

    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
