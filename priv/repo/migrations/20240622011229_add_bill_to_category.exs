defmodule OurExpenses.Repo.Migrations.AddBillToCategory do
  use Ecto.Migration

  def change do
    alter table(:categories) do
      add :bill_id, references(:bills, on_delete: :nothing)
    end

    create index(:categories, [:bill_id])
  end
end
