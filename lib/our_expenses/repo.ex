defmodule OurExpenses.Repo do
  use Ecto.Repo,
    otp_app: :our_expenses,
    adapter: Ecto.Adapters.SQLite3
end
