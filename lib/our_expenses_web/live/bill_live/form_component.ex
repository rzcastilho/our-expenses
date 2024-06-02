defmodule OurExpensesWeb.BillLive.FormComponent do
  use OurExpensesWeb, :live_component

  alias OurExpenses.Expenses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage bill records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bill-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:opening_date]} type="date" label="Opening date" />
        <.input field={@form[:closing_date]} type="date" label="Closing date" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bill</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bill: bill} = assigns, socket) do
    changeset = Expenses.change_bill(bill)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"bill" => bill_params}, socket) do
    changeset =
      socket.assigns.bill
      |> Expenses.change_bill(bill_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"bill" => bill_params}, socket) do
    save_bill(socket, socket.assigns.action, bill_params)
  end

  defp save_bill(socket, :edit, bill_params) do
    case Expenses.update_bill(socket.assigns.bill, bill_params) do
      {:ok, bill} ->
        notify_parent({:saved, bill})

        {:noreply,
         socket
         |> put_flash(:info, "Bill updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_bill(socket, :new, bill_params) do
    case Expenses.create_bill(bill_params) do
      {:ok, bill} ->
        notify_parent({:saved, bill})

        {:noreply,
         socket
         |> put_flash(:info, "Bill created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
