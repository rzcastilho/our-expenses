defmodule OurExpenses.ExpensesTest do
  use OurExpenses.DataCase

  alias OurExpenses.Expenses

  describe "categories" do
    alias OurExpenses.Expenses.Category

    import OurExpenses.ExpensesFixtures

    defp create_bill(_) do
      bill = bill_fixture()
      %{bill: bill}
    end

    @invalid_attrs %{name: nil, description: nil, budget: nil}

    setup [:create_bill]

    test "list_categories/0 returns all categories", %{bill: bill} do
      category = category_fixture(%{bill_id: bill.id})
      assert Expenses.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id", %{bill: bill} do
      category = category_fixture(%{bill_id: bill.id})
      assert Expenses.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category", %{bill: bill} do
      valid_attrs = %{
        bill_id: bill.id,
        name: "some name",
        description: "some description",
        budget: 125.23
      }

      assert {:ok, %Category{} = category} = Expenses.create_category(valid_attrs)
      assert category.name == "some name"
      assert category.description == "some description"
      assert category.budget == 125.23
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category", %{bill: bill} do
      category = category_fixture(%{bill_id: bill.id})

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        budget: 245.2
      }

      assert {:ok, %Category{} = category} = Expenses.update_category(category, update_attrs)
      assert category.name == "some updated name"
      assert category.description == "some updated description"
      assert category.budget == 245.2
    end

    test "update_category/2 with invalid data returns error changeset", %{bill: bill} do
      category = category_fixture(%{bill_id: bill.id})
      assert {:error, %Ecto.Changeset{}} = Expenses.update_category(category, @invalid_attrs)
      assert category == Expenses.get_category!(category.id)
    end

    test "delete_category/1 deletes the category", %{bill: bill} do
      category = category_fixture(%{bill_id: bill.id})
      assert {:ok, %Category{}} = Expenses.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset", %{bill: bill} do
      category = category_fixture(%{bill_id: bill.id})
      assert %Ecto.Changeset{} = Expenses.change_category(category)
    end
  end

  describe "owners" do
    alias OurExpenses.Expenses.Owner

    import OurExpenses.ExpensesFixtures

    @invalid_attrs %{name: nil}

    test "list_owners/0 returns all owners" do
      owner = owner_fixture()
      assert Expenses.list_owners() == [owner]
    end

    test "get_owner!/1 returns the owner with given id" do
      owner = owner_fixture()
      assert Expenses.get_owner!(owner.id) == owner
    end

    test "create_owner/1 with valid data creates a owner" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Owner{} = owner} = Expenses.create_owner(valid_attrs)
      assert owner.name == "some name"
    end

    test "create_owner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_owner(@invalid_attrs)
    end

    test "update_owner/2 with valid data updates the owner" do
      owner = owner_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Owner{} = owner} = Expenses.update_owner(owner, update_attrs)
      assert owner.name == "some updated name"
    end

    test "update_owner/2 with invalid data returns error changeset" do
      owner = owner_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_owner(owner, @invalid_attrs)
      assert owner == Expenses.get_owner!(owner.id)
    end

    test "delete_owner/1 deletes the owner" do
      owner = owner_fixture()
      assert {:ok, %Owner{}} = Expenses.delete_owner(owner)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_owner!(owner.id) end
    end

    test "change_owner/1 returns a owner changeset" do
      owner = owner_fixture()
      assert %Ecto.Changeset{} = Expenses.change_owner(owner)
    end
  end

  describe "entries" do
    alias OurExpenses.Expenses.Entry

    import OurExpenses.ExpensesFixtures

    defp create_owner(_) do
      owner = owner_fixture()
      %{owner: owner}
    end

    defp create_category(_) do
      bill = bill_fixture()
      category = category_fixture(%{bill_id: bill.id})
      %{category: category}
    end

    @invalid_attrs %{
      description: nil,
      bill_date: nil,
      amount: nil,
      number_of_installments: nil,
      installment: nil,
      recurring: nil
    }

    setup [:create_bill, :create_owner, :create_category]

    test "list_entries/0 returns all entries", %{bill: bill, owner: owner, category: category} do
      entry =
        entry_fixture(%{bill_id: bill.id, owner_id: owner.id, category_id: category.id})

      assert Expenses.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id", %{
      bill: bill,
      owner: owner,
      category: category
    } do
      entry =
        entry_fixture(%{bill_id: bill.id, owner_id: owner.id, category_id: category.id})

      assert Expenses.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry", %{
      bill: bill,
      owner: owner,
      category: category
    } do
      valid_attrs = %{
        bill_id: bill.id,
        owner_id: owner.id,
        category_id: category.id,
        description: "some description",
        bill_date: ~D[2024-05-23],
        amount: 120.5,
        number_of_installments: 42,
        installment: 42,
        recurring: true
      }

      assert {:ok, %Entry{} = entry} = Expenses.create_entry(valid_attrs)
      assert entry.description == "some description"
      assert entry.bill_date == ~D[2024-05-23]
      assert entry.amount == 120.5
      assert entry.number_of_installments == 42
      assert entry.installment == 42
      assert entry.recurring == true
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry", %{
      bill: bill,
      owner: owner,
      category: category
    } do
      entry = entry_fixture(%{bill_id: bill.id, owner_id: owner.id, category_id: category.id})

      update_attrs = %{
        description: "some updated description",
        bill_date: ~D[2024-05-24],
        amount: 456.7,
        number_of_installments: 43,
        installment: 43,
        recurring: false
      }

      assert {:ok, %Entry{} = entry} = Expenses.update_entry(entry, update_attrs)
      assert entry.description == "some updated description"
      assert entry.bill_date == ~D[2024-05-24]
      assert entry.amount == 456.7
      assert entry.number_of_installments == 43
      assert entry.installment == 43
      assert entry.recurring == false
    end

    test "update_entry/2 with invalid data returns error changeset" do
      bill = bill_fixture()
      owner = owner_fixture()
      category = category_fixture(%{bill_id: bill.id})
      entry = entry_fixture(%{bill_id: bill.id, owner_id: owner.id, category_id: category.id})
      assert {:error, %Ecto.Changeset{}} = Expenses.update_entry(entry, @invalid_attrs)
      assert entry == Expenses.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry", %{bill: bill, owner: owner, category: category} do
      entry = entry_fixture(%{bill_id: bill.id, owner_id: owner.id, category_id: category.id})
      assert {:ok, %Entry{}} = Expenses.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset", %{
      bill: bill,
      owner: owner,
      category: category
    } do
      entry = entry_fixture(%{bill_id: bill.id, owner_id: owner.id, category_id: category.id})
      assert %Ecto.Changeset{} = Expenses.change_entry(entry)
    end
  end

  describe "bills" do
    alias OurExpenses.Expenses.Bill

    import OurExpenses.ExpensesFixtures

    @invalid_attrs %{name: nil, opening_date: nil, closing_date: nil}

    test "list_bills/0 returns all bills" do
      bill = bill_fixture()
      assert Expenses.list_bills() == [bill]
    end

    test "get_bill!/1 returns the bill with given id" do
      bill = bill_fixture()
      assert Expenses.get_bill!(bill.id) == bill
    end

    test "create_bill/1 with valid data creates a bill" do
      valid_attrs = %{
        name: "some name",
        opening_date: ~D[2024-05-23],
        closing_date: ~D[2024-05-23]
      }

      assert {:ok, %Bill{} = bill} = Expenses.create_bill(valid_attrs)
      assert bill.name == "some name"
      assert bill.opening_date == ~D[2024-05-23]
      assert bill.closing_date == ~D[2024-05-23]
    end

    test "create_bill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_bill(@invalid_attrs)
    end

    test "update_bill/2 with valid data updates the bill" do
      bill = bill_fixture()

      update_attrs = %{
        name: "some updated name",
        opening_date: ~D[2024-05-24],
        closing_date: ~D[2024-05-24]
      }

      assert {:ok, %Bill{} = bill} = Expenses.update_bill(bill, update_attrs)
      assert bill.name == "some updated name"
      assert bill.opening_date == ~D[2024-05-24]
      assert bill.closing_date == ~D[2024-05-24]
    end

    test "update_bill/2 with invalid data returns error changeset" do
      bill = bill_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_bill(bill, @invalid_attrs)
      assert bill == Expenses.get_bill!(bill.id)
    end

    test "delete_bill/1 deletes the bill" do
      bill = bill_fixture()
      assert {:ok, %Bill{}} = Expenses.delete_bill(bill)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_bill!(bill.id) end
    end

    test "change_bill/1 returns a bill changeset" do
      bill = bill_fixture()
      assert %Ecto.Changeset{} = Expenses.change_bill(bill)
    end
  end
end
