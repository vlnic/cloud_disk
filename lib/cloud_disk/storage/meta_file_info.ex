defmodule CloudDisk.Storage.MetaFileInfo do
  use Ecto.Schema

  @derive Jason.Encoder

  embedded_schema do
    field :hash_sum, :string, default: nil
    field :hash_algo, :string, default: nil
    field :extension, :string, default: nil
    field :is_binary, :boolean, default: false
    field :size, :integer, default: 0
  end
end
