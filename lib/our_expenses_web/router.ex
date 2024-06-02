defmodule OurExpensesWeb.Router do
  use OurExpensesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {OurExpensesWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OurExpensesWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/categories", CategoryLive.Index, :index
    live "/categories/new", CategoryLive.Index, :new
    live "/categories/:id/edit", CategoryLive.Index, :edit

    live "/categories/:id", CategoryLive.Show, :show
    live "/categories/:id/show/edit", CategoryLive.Show, :edit

    live "/owners", OwnerLive.Index, :index
    live "/owners/new", OwnerLive.Index, :new
    live "/owners/:id/edit", OwnerLive.Index, :edit

    live "/owners/:id", OwnerLive.Show, :show
    live "/owners/:id/show/edit", OwnerLive.Show, :edit

    live "/bills", BillLive.Index, :index
    live "/bills/new", BillLive.Index, :new
    live "/bills/:id/edit", BillLive.Index, :edit

    live "/bills/:id", BillLive.Show, :show
    live "/bills/:id/show/edit", BillLive.Show, :edit

    live "/entries", EntryLive.Index, :index
    live "/entries/new", EntryLive.Index, :new
    live "/entries/:id/edit", EntryLive.Index, :edit

    live "/entries/:id", EntryLive.Show, :show
    live "/entries/:id/show/edit", EntryLive.Show, :edit

    live "/dashboard", DashboardLive.Index, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", OurExpensesWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:our_expenses, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: OurExpensesWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
