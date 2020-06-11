defmodule Rumbl.Accounts.User do
  @moduledoc """
  The accounts struct :id, :name, :username
  Create schema users
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string

    timestamps()
  end
end
