defmodule OurExpensesWeb.OwnerLiveTest do
  use OurExpensesWeb.ConnCase

  import Phoenix.LiveViewTest
  import OurExpenses.ExpensesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_owner(_) do
    owner = owner_fixture()
    %{owner: owner}
  end

  describe "Index" do
    setup [:create_owner]

    test "lists all owners", %{conn: conn, owner: owner} do
      {:ok, _index_live, html} = live(conn, ~p"/owners")

      assert html =~ "Listing Owners"
      assert html =~ owner.name
    end

    test "saves new owner", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/owners")

      assert index_live |> element("a", "New Owner") |> render_click() =~
               "New Owner"

      assert_patch(index_live, ~p"/owners/new")

      assert index_live
             |> form("#owner-form", owner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#owner-form", owner: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/owners")

      html = render(index_live)
      assert html =~ "Owner created successfully"
      assert html =~ "some name"
    end

    test "updates owner in listing", %{conn: conn, owner: owner} do
      {:ok, index_live, _html} = live(conn, ~p"/owners")

      assert index_live |> element("#owners-#{owner.id} a", "Edit") |> render_click() =~
               "Edit Owner"

      assert_patch(index_live, ~p"/owners/#{owner}/edit")

      assert index_live
             |> form("#owner-form", owner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#owner-form", owner: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/owners")

      html = render(index_live)
      assert html =~ "Owner updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes owner in listing", %{conn: conn, owner: owner} do
      {:ok, index_live, _html} = live(conn, ~p"/owners")

      assert index_live |> element("#owners-#{owner.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#owners-#{owner.id}")
    end
  end

  describe "Show" do
    setup [:create_owner]

    test "displays owner", %{conn: conn, owner: owner} do
      {:ok, _show_live, html} = live(conn, ~p"/owners/#{owner}")

      assert html =~ "Show Owner"
      assert html =~ owner.name
    end

    test "updates owner within modal", %{conn: conn, owner: owner} do
      {:ok, show_live, _html} = live(conn, ~p"/owners/#{owner}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Owner"

      assert_patch(show_live, ~p"/owners/#{owner}/show/edit")

      assert show_live
             |> form("#owner-form", owner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#owner-form", owner: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/owners/#{owner}")

      html = render(show_live)
      assert html =~ "Owner updated successfully"
      assert html =~ "some updated name"
    end
  end
end
