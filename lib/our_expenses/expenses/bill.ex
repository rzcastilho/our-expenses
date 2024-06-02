defmodule OurExpenses.Expenses.Bill do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "bills" do
    field :name, :string
    field :opening_date, :date
    field :closing_date, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bill, attrs) do
    bill
    |> cast(attrs, [:name, :opening_date, :closing_date])
    |> validate_required([:name, :opening_date, :closing_date])
  end
end
