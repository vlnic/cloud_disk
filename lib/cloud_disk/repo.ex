defmodule CloudDisk.Repo do
  use Ecto.Repo,
    otp_app: :cloud_disk,
    adapter: Ecto.Adapters.Postgres
end
