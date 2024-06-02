defmodule OurExpensesWeb.EntryLive.FormComponent do
  use OurExpensesWeb, :live_component

  alias OurExpenses.Expenses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage entry records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="entry-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:bill_id]}
          type="select"
          prompt="Select a bill..."
          options={@bills}
          label="Bill"
        />
        <.input
          field={@form[:owner_id]}
          type="select"
          prompt="Select an owner..."
          options={@owners}
          label="Owner"
        />
        <.input
          field={@form[:category_id]}
          type="select"
          prompt="Select a category..."
          options={@categories}
          label="Category"
        />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:bill_date]} type="date" label="Bill date" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:number_of_installments]} type="number" label="Number of installments" />
        <.input field={@form[:installment]} type="number" label="Installment" />
        <.input field={@form[:recurring]} type="checkbox" label="Recurring" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Entry</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{entry: entry} = assigns, socket) do
    changeset = Expenses.change_entry(entry)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:bills, bills_selector(Expenses.list_bills()))
     |> assign(:owners, owners_selector(Expenses.list_owners()))
     |> assign(:categories, categories_selector(Expenses.list_categories()))
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"entry" => entry_params}, socket) do
    changeset =
      socket.assigns.entry
      |> Expenses.change_entry(entry_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"entry" => entry_params}, socket) do
    save_entry(socket, socket.assigns.action, entry_params)
  end

  defp save_entry(socket, :edit, entry_params) do
    case Expenses.update_entry(socket.assigns.entry, entry_params) do
      {:ok, entry} ->
        notify_parent({:saved, entry})

        {:noreply,
         socket
         |> put_flash(:info, "Entry updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_entry(socket, :new, entry_params) do
    case Expenses.create_entry(entry_params) do
      {:ok, entry} ->
        notify_parent({:saved, entry})

        {:noreply,
         socket
         |> put_flash(:info, "Entry created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp bills_selector(bills) do
    for bill <- bills do
      {bill.name, bill.id}
    end
  end

  defp categories_selector(categories) do
    for category <- categories do
      {category.name, category.id}
    end
  end

  defp owners_selector(owners) do
    for owner <- owners do
      {owner.name, owner.id}
    end
  end
end