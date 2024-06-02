defmodule OurExpensesWeb.EntryLive.Index do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses
  alias OurExpenses.Expenses.Entry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :entries, Expenses.list_entries())}
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

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Entries")
    |> assign(:entry, nil)
  end

  @impl true
  def handle_info({OurExpensesWeb.EntryLive.FormComponent, {:saved, entry}}, socket) do
    {:noreply, stream_insert(socket, :entries, entry)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    entry = Expenses.get_entry!(id)
    {:ok, _} = Expenses.delete_entry(entry)

    {:noreply, stream_delete(socket, :entries, entry)}
  end
end
