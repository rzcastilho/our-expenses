defmodule OurExpensesWeb.EntryLive.Index do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses
  alias OurExpenses.Expenses.Entry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Entry")
    |> assign(:entry, Expenses.get_entry!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Entry")
    |> assign(:entry, %Entry{})
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
    |> assign(:page_title, "Listing Entries")
    |> assign(:entry, nil)
    |> stream(:entries, Expenses.list_entries_by_bill(bill.id))
    |> assign(:balance, Expenses.total_balance(bill))
    |> assign(:bill, bill)
  end

  @impl true
  def handle_info(
        {OurExpensesWeb.EntryLive.FormComponent, {:saved, entry}},
        %{assigns: %{bill: bill}} = socket
      ) do
    {
      :noreply,
      socket
      |> stream_insert(:entries, entry, at: 0)
      |> assign(:balance, Expenses.total_balance(bill))
    }
  end

  @impl true
  def handle_event("delete", %{"id" => id}, %{assigns: %{bill: bill}} = socket) do
    entry = Expenses.get_entry!(id)
    {:ok, _} = Expenses.delete_entry(entry)

    {
      :noreply,
      socket
      |> stream_delete(:entries, entry)
      |> assign(:balance, Expenses.total_balance(bill))
    }
  end
end
