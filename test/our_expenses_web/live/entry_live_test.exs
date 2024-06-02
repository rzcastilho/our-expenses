defmodule OurExpensesWeb.EntryLiveTest do
  use OurExpensesWeb.ConnCase

  import Phoenix.LiveViewTest
  import OurExpenses.ExpensesFixtures

  @create_attrs %{
    description: "some description",
    bill_date: "2024-05-23",
    amount: 120.5,
    number_of_installments: 42,
    installment: 42,
    recurring: true
  }
  @update_attrs %{
    description: "some updated description",
    bill_date: "2024-05-24",
    amount: 456.7,
    number_of_installments: 43,
    installment: 43,
    recurring: false
  }
  @invalid_attrs %{
    description: nil,
    bill_date: nil,
    amount: nil,
    number_of_installments: nil,
    installment: nil,
    recurring: false
  }

  defp create_entry(_) do
    bill = bill_fixture()
    owner = owner_fixture()
    category = category_fixture()

    entry =
      entry_fixture(%{bill_id: bill.id, owner_id: owner.id, category_id: category.id})

    %{entry: entry}
  end

  defp create_bill(_) do
    bill = bill_fixture()
    %{bill: bill}
  end

  defp create_owner(_) do
    owner = owner_fixture()
    %{owner: owner}
  end

  defp create_category(_) do
    category = category_fixture()
    %{category: category}
  end

  describe "Index" do
    setup [:create_entry, :create_bill, :create_owner, :create_category]

    test "lists all entries", %{conn: conn, entry: entry} do
      {:ok, _index_live, html} = live(conn, ~p"/entries")

      assert html =~ "Listing Entries"
      assert html =~ entry.description
    end

    test "saves new entry", %{conn: conn, bill: bill, owner: owner, category: category} do
      {:ok, index_live, _html} = live(conn, ~p"/entries")

      assert index_live |> element("a", "New Entry") |> render_click() =~
               "New Entry"

      assert_patch(index_live, ~p"/entries/new")

      assert index_live
             |> form("#entry-form", entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#entry-form",
               entry:
                 @create_attrs
                 |> Map.put(:bill_id, bill.id)
                 |> Map.put(:owner_id, owner.id)
                 |> Map.put(:category_id, category.id)
             )
             |> render_submit()

      assert_patch(index_live, ~p"/entries")

      html = render(index_live)
      assert html =~ "Entry created successfully"
      assert html =~ "some description"
    end

    test "updates entry in listing", %{conn: conn, entry: entry} do
      {:ok, index_live, _html} = live(conn, ~p"/entries")

      assert index_live |> element("#entries-#{entry.id} a", "Edit") |> render_click() =~
               "Edit Entry"

      assert_patch(index_live, ~p"/entries/#{entry}/edit")

      assert index_live
             |> form("#entry-form", entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#entry-form", entry: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/entries")

      html = render(index_live)
      assert html =~ "Entry updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes entry in listing", %{conn: conn, entry: entry} do
      {:ok, index_live, _html} = live(conn, ~p"/entries")

      assert index_live |> element("#entries-#{entry.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#entries-#{entry.id}")
    end
  end

  describe "Show" do
    setup [:create_entry]

    test "displays entry", %{conn: conn, entry: entry} do
      {:ok, _show_live, html} = live(conn, ~p"/entries/#{entry}")

      assert html =~ "Show Entry"
      assert html =~ entry.description
    end

    test "updates entry within modal", %{conn: conn, entry: entry} do
      {:ok, show_live, _html} = live(conn, ~p"/entries/#{entry}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Entry"

      assert_patch(show_live, ~p"/entries/#{entry}/show/edit")

      assert show_live
             |> form("#entry-form", entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#entry-form", entry: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/entries/#{entry}")

      html = render(show_live)
      assert html =~ "Entry updated successfully"
      assert html =~ "some updated description"
    end
  end
end
