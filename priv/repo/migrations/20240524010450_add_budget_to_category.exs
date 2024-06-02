defmodule OurExpenses.Repo.Migrations.AddBudgetToCategory do
  use Ecto.Migration

  def change do
    alter table(:categories) do
      add :budget, :float
    end
  end
end
