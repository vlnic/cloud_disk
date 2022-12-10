defmodule CloudDisk.StorageTest do
  use CloudDisk.DataCase

  alias CloudDisk.Storage

  describe "files" do
    alias CloudDisk.Storage.File

    import CloudDisk.StorageFixtures

    @invalid_attrs %{name: nil, public_name: nil}

    test "list_files/0 returns all files" do
      file = file_fixture()
      assert Storage.list_files() == [file]
    end

    test "get_file!/1 returns the file with given id" do
      file = file_fixture()
      assert Storage.get_file!(file.id) == file
    end

    test "create_file/1 with valid data creates a file" do
      valid_attrs = %{name: "some name", public_name: "some public_name"}

      assert {:ok, %File{} = file} = Storage.create_file(valid_attrs)
      assert file.name == "some name"
      assert file.public_name == "some public_name"
    end

    test "create_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Storage.create_file(@invalid_attrs)
    end

    test "update_file/2 with valid data updates the file" do
      file = file_fixture()
      update_attrs = %{name: "some updated name", public_name: "some updated public_name"}

      assert {:ok, %File{} = file} = Storage.update_file(file, update_attrs)
      assert file.name == "some updated name"
      assert file.public_name == "some updated public_name"
    end

    test "update_file/2 with invalid data returns error changeset" do
      file = file_fixture()
      assert {:error, %Ecto.Changeset{}} = Storage.update_file(file, @invalid_attrs)
      assert file == Storage.get_file!(file.id)
    end

    test "delete_file/1 deletes the file" do
      file = file_fixture()
      assert {:ok, %File{}} = Storage.delete_file(file)
      assert_raise Ecto.NoResultsError, fn -> Storage.get_file!(file.id) end
    end

    test "change_file/1 returns a file changeset" do
      file = file_fixture()
      assert %Ecto.Changeset{} = Storage.change_file(file)
    end
  end
end
