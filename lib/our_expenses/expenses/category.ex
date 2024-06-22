defmodule OurExpenses.Expenses.Category do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias OurExpenses.Expenses.{
    Bill,
    Entry
  }

  schema "categories" do
    field :name, :string
    field :description, :string
    field :budget, :float

    belongs_to :bill, Bill
    has_many :entries, Entry

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:bill_id, :name, :description, :budget])
    |> validate_required([:bill_id, :name, :description, :budget])
    |> foreign_key_constraint(:bill_id)
  end
end
