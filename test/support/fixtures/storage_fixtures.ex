defmodule CloudDisk.StorageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CloudDisk.Storage` context.
  """

  @doc """
  Generate a file.
  """
  def file_fixture(attrs \\ %{}) do
    {:ok, file} =
      attrs
      |> Enum.into(%{
        name: "some name",
        public_name: "some public_name"
      })
      |> CloudDisk.Storage.create_file()

    file
  end
end
