defmodule OurExpensesWeb.DashboardLive.Index do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses
  alias OurExpenses.Expenses.Category

  @impl true
  def mount(_params, _session, socket) do
    bill = Expenses.current_bill() || Expenses.last_bill()

    {
      :ok,
      socket
      |> assign(:bill, bill)
      |> assign(:budget, Expenses.total_budget(bill))
      |> assign(:balance, Expenses.total_balance(bill))
      |> assign(:balance_grouped_by_category, Expenses.balance_grouped_by_category(bill))
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :details, %{"category_id" => category_id}) do
    with %Category{} = category <- Expenses.get_category!(category_id) do
      socket
      |> assign(:category, category)
    end
  end

  defp apply_action(socket, :index, _params), do: socket
end
