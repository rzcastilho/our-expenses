defmodule OurExpensesWeb.DashboardLive.DetailsComponent do
  use OurExpensesWeb, :live_component

  alias OurExpenses.Expenses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @category.name %>
        <:subtitle>Bill details by category.</:subtitle>
      </.header>
      <.table id="details" rows={@streams.entries}>
        <:col :let={{_id, entry}} label="Date"><%= entry.bill_date %></:col>
        <:col :let={{_id, entry}} label="Owner"><%= entry.owner.name %></:col>
        <:col :let={{_id, entry}} label="Description"><%= entry.description %></:col>
        <:col :let={{_id, entry}} label="Amount">
          $ <%= :erlang.float_to_binary(entry.amount, decimals: 2) %>
        </:col>
      </.table>
    </div>
    """
  end

  @impl true
  def update(%{bill: bill, category: category}, socket) do
    {
      :ok,
      socket
      |> assign(:category, category)
      |> stream(:entries, Expenses.list_entries_by_bill_and_category(bill.id, category.id))
    }
  end
end
