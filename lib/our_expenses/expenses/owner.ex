defmodule OurExpenses.Expenses.Owner do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "owners" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(owner, attrs) do
    owner
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
