defmodule OurExpensesWeb.DashboardLive.Index do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses
  alias OurExpenses.Expenses.Category

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
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

  defp apply_action(socket, :index, params) do
    bill =
      case params do
        %{"bill_id" => bill_id} ->
          Expenses.get_bill!(bill_id)

        _ ->
          Expenses.current_bill() || Expenses.last_bill()
      end

    socket
    |> assign(:bill, bill)
    |> assign(:nav, Expenses.next_and_previous_bills(bill))
    |> assign(:status, Expenses.bill_status(bill))
    |> assign(:budget, Expenses.total_budget(bill))
    |> assign(:balance, Expenses.total_balance(bill))
    |> assign(:installments, Expenses.total_installments(bill))
    |> assign(:recurring, Expenses.total_recurring(bill))
    |> assign(:balance_grouped_by_category, Expenses.balance_grouped_by_category(bill))
  end
end
