defmodule OurExpensesWeb.CategoryLive.Index do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses
  alias OurExpenses.Expenses.Category

  @impl true
  def mount(_params, _session, socket) do
    bill = Expenses.current_bill() || Expenses.last_bill()

    {
      :ok,
      socket
      |> stream(:categories, Expenses.list_categories_by_bill(bill.id))
      |> assign(:total_budget, Expenses.total_budget(bill) || 0.0)
      |> assign(:bill, bill)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Category")
    |> assign(:category, Expenses.get_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Category")
    |> assign(:category, %Category{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Categories")
    |> assign(:category, nil)
  end

  @impl true
  def handle_info({OurExpensesWeb.CategoryLive.FormComponent, {:saved, category}}, socket) do
    {
      :noreply,
      socket
      |> stream_insert(:categories, category)
      |> assign(:total_budget, Expenses.total_budget(socket.assigns.bill) || 0.0)
    }
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    category = Expenses.get_category!(id)
    {:ok, _} = Expenses.delete_category(category)

    {
      :noreply,
      socket
      |> stream_delete(:categories, category)
      |> assign(:total_budget, Expenses.total_budget(socket.assigns.bill) || 0.0)
    }
  end
end
