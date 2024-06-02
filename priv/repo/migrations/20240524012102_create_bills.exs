defmodule OurExpenses.Repo.Migrations.CreateBills do
  use Ecto.Migration

  def change do
    create table(:bills) do
      add :name, :string
      add :opening_date, :date
      add :closing_date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
