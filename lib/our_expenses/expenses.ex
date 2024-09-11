defmodule OurExpenses.Expenses do
  @moduledoc """
  The Expenses context.
  """

  import Ecto.Query, warn: false
  alias OurExpenses.Repo

  alias OurExpenses.Expenses.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  def list_categories_by_bill(bill_id) do
    from(c in Category)
    |> where([c], c.bill_id == ^bill_id)
    |> Repo.all()
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  def total_budget(%OurExpenses.Expenses.Bill{} = bill) do
    from(c in Category)
    |> where([c], c.bill_id == ^bill.id)
    |> select([c], type(coalesce(sum(c.budget), 0.0), :float))
    |> Repo.one()
  end

  alias OurExpenses.Expenses.Owner

  @doc """
  Returns the list of owners.

  ## Examples

      iex> list_owners()
      [%Owner{}, ...]

  """
  def list_owners do
    Repo.all(Owner)
  end

  @doc """
  Gets a single owner.

  Raises `Ecto.NoResultsError` if the Owner does not exist.

  ## Examples

      iex> get_owner!(123)
      %Owner{}

      iex> get_owner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_owner!(id), do: Repo.get!(Owner, id)

  @doc """
  Creates a owner.

  ## Examples

      iex> create_owner(%{field: value})
      {:ok, %Owner{}}

      iex> create_owner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_owner(attrs \\ %{}) do
    %Owner{}
    |> Owner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a owner.

  ## Examples

      iex> update_owner(owner, %{field: new_value})
      {:ok, %Owner{}}

      iex> update_owner(owner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_owner(%Owner{} = owner, attrs) do
    owner
    |> Owner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a owner.

  ## Examples

      iex> delete_owner(owner)
      {:ok, %Owner{}}

      iex> delete_owner(owner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_owner(%Owner{} = owner) do
    Repo.delete(owner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking owner changes.

  ## Examples

      iex> change_owner(owner)
      %Ecto.Changeset{data: %Owner{}}

  """
  def change_owner(%Owner{} = owner, attrs \\ %{}) do
    Owner.changeset(owner, attrs)
  end

  alias OurExpenses.Expenses.Entry

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries do
    Repo.all(Entry)
  end

  def list_entries_by_bill_and_category(bill_id, category_id) do
    from(e in Entry)
    |> where([e], e.bill_id == ^bill_id)
    |> where([e], e.category_id == ^category_id)
    |> order_by([e], e.bill_date)
    |> preload(:owner)
    |> Repo.all()
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id)

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entry.

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{data: %Entry{}}

  """
  def change_entry(%Entry{} = entry, attrs \\ %{}) do
    Entry.changeset(entry, attrs)
  end

  alias OurExpenses.Expenses.Bill

  @doc """
  Returns the list of bills.

  ## Examples

      iex> list_bills()
      [%Bill{}, ...]

  """
  def list_bills do
    Repo.all(Bill)
  end

  @doc """
  Gets a single bill.

  Raises `Ecto.NoResultsError` if the Bill does not exist.

  ## Examples

      iex> get_bill!(123)
      %Bill{}

      iex> get_bill!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bill!(id), do: Repo.get!(Bill, id)

  @doc """
  Creates a bill.

  ## Examples

      iex> create_bill(%{field: value})
      {:ok, %Bill{}}

      iex> create_bill(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bill(attrs \\ %{}) do
    %Bill{}
    |> Bill.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bill.

  ## Examples

      iex> update_bill(bill, %{field: new_value})
      {:ok, %Bill{}}

      iex> update_bill(bill, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bill(%Bill{} = bill, attrs) do
    bill
    |> Bill.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bill.

  ## Examples

      iex> delete_bill(bill)
      {:ok, %Bill{}}

      iex> delete_bill(bill)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bill(%Bill{} = bill) do
    Repo.delete(bill)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bill changes.

  ## Examples

      iex> change_bill(bill)
      %Ecto.Changeset{data: %Bill{}}

  """
  def change_bill(%Bill{} = bill, attrs \\ %{}) do
    Bill.changeset(bill, attrs)
  end

  def current_bill() do
    now = NaiveDateTime.utc_now()

    Bill
    |> where([b], b.opening_date <= ^now)
    |> where([b], b.closing_date >= ^now)
    |> Repo.one()
  end

  def last_bill() do
    from(b in Bill)
    |> order_by([b], desc: b.closing_date)
    |> limit(1)
    |> Repo.one()
  end

  def balance_grouped_by_category(%Bill{} = bill) do
    from(c in Category)
    |> where([c], c.bill_id == ^bill.id)
    |> join(:left, [c], e in Entry, on: c.id == e.category_id and c.bill_id == e.bill_id)
    |> group_by([c], [c.id, c.name, c.budget])
    |> select([c, e], {c.id, c.name, c.budget, type(coalesce(sum(e.amount), 0.0), :float)})
    |> order_by([c], c.name)
    |> Repo.all()
  end

  def total_balance(%Bill{} = bill) do
    from(e in Entry)
    |> where([e], e.bill_id == ^bill.id)
    |> select([e], coalesce(sum(e.amount), 0))
    |> Repo.one()
  end

  def total_installments(%Bill{} = bill) do
    from(e in Entry)
    |> where([e], e.bill_id == ^bill.id and e.number_of_installments > 1)
    |> select([e], coalesce(sum(e.amount), 0))
    |> Repo.one()
  end

  def total_recurring(%Bill{} = bill) do
    from(e in Entry)
    |> where([e], e.bill_id == ^bill.id and e.recurring == true)
    |> select([e], coalesce(sum(e.amount), 0))
    |> Repo.one()
  end

  def bill_status(%{opening_date: opening, closing_date: closing}) do
    if Timex.between?(Timex.today(), opening, closing, inclusive: true) do
      "open"
    else
      "closed"
    end
  end

  def get_bill_by_date(date) do
    from(b in Bill)
    |> where([b], b.opening_date <= ^date)
    |> where([b], b.closing_date >= ^date)
    |> Repo.one()
  end

  def next_and_previous_bills(%{opening_date: opening, closing_date: closing}) do
    %{
      previous:
        opening
        |> Date.add(-5)
        |> get_bill_by_date(),
      next:
        closing
        |> Date.add(5)
        |> get_bill_by_date()
    }
  end

  def copy_categories(bill_from, bill_to) do
    bill_from
    |> list_categories_by_bill()
    |> Enum.map(&Map.from_struct/1)
    |> Enum.map(fn map ->
      [:id, :bill, :inserted_at, :updated_at, :entries, :__meta__]
      |> Enum.reduce(map, fn key, acc -> Map.delete(acc, key) end)
    end)
    |> Enum.map(&Map.put(&1, :bill_id, bill_to))
    |> Enum.map(&change_category(%Category{}, &1))
    |> Enum.map(&Repo.insert!/1)
  end

  def get_category_by_bill_and_name(bill_id, name) do
    from(c in Category)
    |> where([c], c.bill_id == ^bill_id)
    |> where([c], c.name == ^name)
    |> select([c], c.id)
    |> Repo.one()
  end

  def copy_installments(bill_from, bill_to) do
    from(e in Entry)
    |> where([e], e.bill_id == ^bill_from)
    |> where([e], e.number_of_installments > 1)
    |> where([e], e.number_of_installments != e.installment)
    |> preload(:category)
    |> Repo.all()
    |> Enum.map(&Map.from_struct/1)
    |> Enum.map(fn %{category: %{name: name}} = map -> Map.put(map, :category_name, name) end)
    |> Enum.map(fn map ->
      [:id, :bill, :owner, :category, :inserted_at, :updated_at, :__meta__]
      |> Enum.reduce(map, fn key, acc -> Map.delete(acc, key) end)
    end)
    |> Enum.map(&Map.put(&1, :bill_id, bill_to))
    |> Enum.map(&Map.put(&1, :bill_date, Timex.shift(&1.bill_date, months: 1)))
    |> Enum.map(fn %{category_name: name} = map ->
      case get_category_by_bill_and_name(bill_to, name) do
        nil -> map |> Map.delete(:category_id) |> Map.delete(:category_name)
        id -> map |> Map.put(:category_id, id) |> Map.delete(:category_name)
      end
    end)
    |> Enum.map(&Map.put(&1, :installment, &1.installment + 1))
    |> Enum.map(&change_entry(%Entry{}, &1))
    |> Enum.map(&Repo.insert!/1)
  end

  def copy_recurring(bill_from, bill_to) do
    from(e in Entry)
    |> where([e], e.bill_id == ^bill_from)
    |> where([e], e.recurring == true)
    |> preload(:category)
    |> Repo.all()
    |> Enum.map(&Map.from_struct/1)
    |> Enum.map(fn %{category: %{name: name}} = map -> Map.put(map, :category_name, name) end)
    |> Enum.map(fn map ->
      [:id, :bill, :category, :owner, :inserted_at, :updated_at, :__meta__]
      |> Enum.reduce(map, fn key, acc -> Map.delete(acc, key) end)
    end)
    |> Enum.map(&Map.put(&1, :bill_id, bill_to))
    |> Enum.map(&Map.put(&1, :bill_date, Timex.shift(&1.bill_date, months: 1)))
    |> Enum.map(fn %{category_name: name} = map ->
      case get_category_by_bill_and_name(bill_to, name) do
        nil -> map |> Map.delete(:category_id) |> Map.delete(:category_name)
        id -> map |> Map.put(:category_id, id) |> Map.delete(:category_name)
      end
    end)
    |> Enum.map(&change_entry(%Entry{}, &1))
    |> Enum.map(&Repo.insert!/1)
  end
end
