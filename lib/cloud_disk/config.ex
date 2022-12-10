defmodule CloudDisk.Config do

  @callback fetch(key :: String.t() | atom(), default :: any()) :: any()
  def fetch(key, default) do
    Application.get_env(:cloud_disk, key, default)
  end
end
