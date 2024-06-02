defmodule OurExpensesWeb.BillLive.Index do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses
  alias OurExpenses.Expenses.Bill

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bills, Expenses.list_bills())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bill")
    |> assign(:bill, Expenses.get_bill!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bill")
    |> assign(:bill, %Bill{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bills")
    |> assign(:bill, nil)
  end

  @impl true
  def handle_info({OurExpensesWeb.BillLive.FormComponent, {:saved, bill}}, socket) do
    {:noreply, stream_insert(socket, :bills, bill)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bill = Expenses.get_bill!(id)
    {:ok, _} = Expenses.delete_bill(bill)

    {:noreply, stream_delete(socket, :bills, bill)}
  end
end
