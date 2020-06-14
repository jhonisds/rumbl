defmodule RumblWeb.SessionController do
  @moduledoc """
  Session Controller Module
  """
  use RumblWeb, :controller

  alias Rumbl.Accounts
  alias RumblWeb.Auth

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => pass}}) do
    case Accounts.authenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        # IO.inspect(user.name, label: "[Session Controller create]")

        conn
        |> Auth.login(user)
        |> put_flash(:info, "Welcome back #{user.name}!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
