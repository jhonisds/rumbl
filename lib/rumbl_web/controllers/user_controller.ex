defmodule RumblWeb.UserController do
  @moduledoc """
  The User Controller module
  """
  use RumblWeb, :controller

  alias Rumbl.{Accounts, Accounts.User}

  plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    # IO.inspect(conn, label: "[User Controller index]")
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    # IO.inspect(conn, label: "[User Controller]")
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{}, %{})
    IO.inspect(changeset, label: "[User Controller new]")
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    IO.inspect(user_params, label: "[User Controller create]")

    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User: #{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate(conn, _opts) do
    IO.inspect(conn, label: "[User Controller authenticate]")

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
