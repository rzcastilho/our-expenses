defmodule OurExpenses.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :description, :string
      add :bill_date, :date
      add :amount, :float
      add :number_of_installments, :integer
      add :installment, :integer
      add :recurring, :boolean, default: false, null: false
      add :owner_id, references(:owners, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:entries, [:owner_id])
    create index(:entries, [:category_id])
  end
end
