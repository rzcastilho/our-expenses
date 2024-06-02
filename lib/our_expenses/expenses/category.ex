defmodule OurExpenses.Expenses.Category do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias OurExpenses.Expenses.Entry

  schema "categories" do
    field :name, :string
    field :description, :string
    field :budget, :float

    has_many :entries, Entry

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description, :budget])
    |> validate_required([:name, :description, :budget])
  end
end
