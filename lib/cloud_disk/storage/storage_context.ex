defmodule CloudDisk.StorageContext do
  alias CloudDisk.Storage.CloudFile
  alias CloudDisk.Repo

  require Logger

  @config CloudDisk.config_impl()

  def upload_files(user, files, target_path) do
    Enum.map(files, fn(file) ->
      case move_to_user_path(user, file, target_path) do
        {:ok, filename} ->
          filename
          |> prepare_info(file)
          |> save_file(user)

        {:error, reason} ->
          {:error, reason}
      end
    end)
  end

  defp save_file(file_info, user) do
    %CloudFile{user_id: user.user_id}
    |> CloudFile.changeset(file_info)
    |> Repo.insert!()
  end

  defp prepare_info(user_path, %Plug.Upload{path: path}) do
    case File.stat(path) do
      {:ok, %File.Stat{size: size}} ->
        %{
          path: user_path,
          public_name: Path.basename(path),
          meta: %{
            size: size,
            extension: Path.extname(path)
          }
        }

      {:error, reason} ->
        %{error: reason}
    end
  end

  defp move_to_user_path(user, file, target_path) do
    filename = filename(user, file, target_path)
    case File.cp(file.path, filename) do
      :ok ->
        {:ok, filename}

      {:error, reason} ->
        Logger.error("save file error: #{inspect reason}")
        {:error, reason}
    end
  end

  def filename(user, %Plug.Upload{path: path}, target_path) do
    Path.join([@config.root_path, "/", user.user_id], [target_path, "/", Path.basename(path)])
  end
end
