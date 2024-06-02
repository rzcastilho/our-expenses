defmodule OurExpensesWeb.DashboardLive.Index do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses

  @impl true
  def mount(_params, _session, socket) do
    bill = Expenses.current_bill()

    {
      :ok,
      socket
      |> assign(:bill, Expenses.current_bill())
      |> assign(:budget, Expenses.total_budget())
      |> assign(:balance, Expenses.total_balance(bill))
      |> assign(:balance_grouped_by_category, Expenses.balance_grouped_by_category(bill))
    }
  end
end
