defmodule CloudDisk.Storage.CloudFile do
  use CloudDiskWeb, :model

  alias CloudDisk.UserContext.User

  @primary_key {:file_id, :uuid, autogenerate: true}

  schema "files" do
    field :path, :string
    field :public_name, :string

    embeds_one :meta, CloudDisk.Storage.MetaFileInfo

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:public_name, :name])
    |> validate_required([:public_name, :name])
  end
end
