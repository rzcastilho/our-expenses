defmodule OurExpenses.Repo.Migrations.AddBillToEntry do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      add :bill_id, references(:bills, on_delete: :nothing)
    end

    create index(:entries, [:bill_id])
  end
end
