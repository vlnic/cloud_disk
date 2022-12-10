defmodule CloudDisk do
  @moduledoc """
  CloudDisk keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def config_impl do
    Application.get_env(:cloud_disk, :config_impl, CloudDisk.Config)
  end
end
