defmodule OurExpensesWeb.OwnerLive.FormComponent do
  use OurExpensesWeb, :live_component

  alias OurExpenses.Expenses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage owner records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="owner-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Owner</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{owner: owner} = assigns, socket) do
    changeset = Expenses.change_owner(owner)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"owner" => owner_params}, socket) do
    changeset =
      socket.assigns.owner
      |> Expenses.change_owner(owner_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"owner" => owner_params}, socket) do
    save_owner(socket, socket.assigns.action, owner_params)
  end

  defp save_owner(socket, :edit, owner_params) do
    case Expenses.update_owner(socket.assigns.owner, owner_params) do
      {:ok, owner} ->
        notify_parent({:saved, owner})

        {:noreply,
         socket
         |> put_flash(:info, "Owner updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_owner(socket, :new, owner_params) do
    case Expenses.create_owner(owner_params) do
      {:ok, owner} ->
        notify_parent({:saved, owner})

        {:noreply,
         socket
         |> put_flash(:info, "Owner created successfully")
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
