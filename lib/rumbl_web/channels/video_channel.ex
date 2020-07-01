defmodule RumblWeb.VideoChannel do
  @moduledoc """
  Build the Channel Video Module
  """
  use RumblWeb, :channel

  def join("videos:" <> video_id, _params, socket) do
    {:ok, assign(socket, :video_id, String.to_integer(video_id))}
  end
end
