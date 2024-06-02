defmodule OurExpensesWeb.BillLive.Show do
  use OurExpensesWeb, :live_view

  alias OurExpenses.Expenses

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bill, Expenses.get_bill!(id))}
  end

  defp page_title(:show), do: "Show Bill"
  defp page_title(:edit), do: "Edit Bill"
end
