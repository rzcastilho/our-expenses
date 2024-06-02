defmodule OurExpensesWeb.OwnerLive.Index do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses
  alias OurExpenses.Expenses.Owner

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :owners, Expenses.list_owners())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Owner")
    |> assign(:owner, Expenses.get_owner!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Owner")
    |> assign(:owner, %Owner{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Owners")
    |> assign(:owner, nil)
  end

  @impl true
  def handle_info({OurExpensesWeb.OwnerLive.FormComponent, {:saved, owner}}, socket) do
    {:noreply, stream_insert(socket, :owners, owner)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    owner = Expenses.get_owner!(id)
    {:ok, _} = Expenses.delete_owner(owner)

    {:noreply, stream_delete(socket, :owners, owner)}
  end
end
