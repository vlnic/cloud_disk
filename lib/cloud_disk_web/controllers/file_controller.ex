defmodule CloudDiskWeb.FileController do
  use CloudDiskWeb, :controller

  alias CloudDisk.StorageContext

  def upload(conn, %{"files" => files, "target_path" => path}) do
    uploaded = StorageContext.upload_files(conn.current_user, files, path)

    json(conn, %{
      "errors" => upload_errors(uploaded),
      "uploads" => success_uploads(uploaded)
    })
  end

  defp upload_errors(files) do
    files
    |> Enum.filter(fn
      ({:error, reason}) -> true
      (_) -> false
    end)
    |> Enum.map(fn({:error, reason}) ->
      reason
    end)
  end

  defp success_uploads(files) do
    files
    |> Enum.filter(fn
      ({:error, reason}) -> false
      (_) -> true
    end)
    |> Enum.map(fn(file) -> file.public_name end)
  end
end
