defmodule OurExpensesWeb.BillLiveTest do
  use OurExpensesWeb.ConnCase

  import Phoenix.LiveViewTest
  import OurExpenses.ExpensesFixtures

  @create_attrs %{name: "some name", opening_date: "2024-05-23", closing_date: "2024-05-23"}
  @update_attrs %{
    name: "some updated name",
    opening_date: "2024-05-24",
    closing_date: "2024-05-24"
  }
  @invalid_attrs %{name: nil, opening_date: nil, closing_date: nil}

  defp create_bill(_) do
    bill = bill_fixture()
    %{bill: bill}
  end

  describe "Index" do
    setup [:create_bill]

    test "lists all bills", %{conn: conn, bill: bill} do
      {:ok, _index_live, html} = live(conn, ~p"/bills")

      assert html =~ "Listing Bills"
      assert html =~ bill.name
    end

    test "saves new bill", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bills")

      assert index_live |> element("a", "New Bill") |> render_click() =~
               "New Bill"

      assert_patch(index_live, ~p"/bills/new")

      assert index_live
             |> form("#bill-form", bill: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bill-form", bill: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bills")

      html = render(index_live)
      assert html =~ "Bill created successfully"
      assert html =~ "some name"
    end

    test "updates bill in listing", %{conn: conn, bill: bill} do
      {:ok, index_live, _html} = live(conn, ~p"/bills")

      assert index_live |> element("#bills-#{bill.id} a", "Edit") |> render_click() =~
               "Edit Bill"

      assert_patch(index_live, ~p"/bills/#{bill}/edit")

      assert index_live
             |> form("#bill-form", bill: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bill-form", bill: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bills")

      html = render(index_live)
      assert html =~ "Bill updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes bill in listing", %{conn: conn, bill: bill} do
      {:ok, index_live, _html} = live(conn, ~p"/bills")

      assert index_live |> element("#bills-#{bill.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bills-#{bill.id}")
    end
  end

  describe "Show" do
    setup [:create_bill]

    test "displays bill", %{conn: conn, bill: bill} do
      {:ok, _show_live, html} = live(conn, ~p"/bills/#{bill}")

      assert html =~ "Show Bill"
      assert html =~ bill.name
    end

    test "updates bill within modal", %{conn: conn, bill: bill} do
      {:ok, show_live, _html} = live(conn, ~p"/bills/#{bill}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bill"

      assert_patch(show_live, ~p"/bills/#{bill}/show/edit")

      assert show_live
             |> form("#bill-form", bill: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bill-form", bill: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bills/#{bill}")

      html = render(show_live)
      assert html =~ "Bill updated successfully"
      assert html =~ "some updated name"
    end
  end
end
