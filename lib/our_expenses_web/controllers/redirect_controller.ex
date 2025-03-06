defmodule OurExpensesWeb.RedirectController do
  use OurExpensesWeb, :controller

  def to(conn, _params) do
    redirect(conn, to: "/dashboard")
  end
end
