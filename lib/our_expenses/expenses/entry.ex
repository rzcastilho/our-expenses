defmodule OurExpenses.Expenses.Entry do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias OurExpenses.Expenses.{
    Bill,
    Category,
    Owner
  }

  schema "entries" do
    field :description, :string
    field :bill_date, :date
    field :amount, :float
    field :number_of_installments, :integer
    field :installment, :integer
    field :recurring, :boolean, default: false

    belongs_to :owner, Owner
    belongs_to :bill, Bill
    belongs_to :category, Category

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [
      :bill_id,
      :owner_id,
      :category_id,
      :description,
      :bill_date,
      :amount,
      :number_of_installments,
      :installment,
      :recurring
    ])
    |> validate_required([
      :bill_id,
      :owner_id,
      :category_id,
      :description,
      :bill_date,
      :amount,
      :number_of_installments,
      :installment,
      :recurring
    ])
    |> foreign_key_constraint(:bill_id)
    |> foreign_key_constraint(:owner_id)
    |> foreign_key_constraint(:category_id)
  end
end
