defmodule OurExpenses.ExpensesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OurExpenses.Expenses` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        budget: 600.25
      })
      |> OurExpenses.Expenses.create_category()

    category
  end

  @doc """
  Generate a owner.
  """
  def owner_fixture(attrs \\ %{}) do
    {:ok, owner} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> OurExpenses.Expenses.create_owner()

    owner
  end

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        bill_date: ~D[2024-05-23],
        description: "some description",
        installment: 42,
        number_of_installments: 42,
        recurring: true
      })
      |> OurExpenses.Expenses.create_entry()

    entry
  end

  @doc """
  Generate a bill.
  """
  def bill_fixture(attrs \\ %{}) do
    {:ok, bill} =
      attrs
      |> Enum.into(%{
        closing_date: ~D[2024-05-23],
        name: "some name",
        opening_date: ~D[2024-05-23]
      })
      |> OurExpenses.Expenses.create_bill()

    bill
  end
end
