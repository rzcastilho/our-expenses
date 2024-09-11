defmodule OurExpensesWeb.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  require Logger

  @app :our_expenses

  def migrate do
    load_app()

    for repo <- repos() do
      case repo.__adapter__().storage_up(repo.config()) do
        :ok ->
          Logger.info("The database for #{inspect(repo)} has been created")

        {:error, :already_up} ->
          Logger.info("The database for #{inspect(repo)} has already been created")

        {:error, term} when is_binary(term) ->
          Logger.error("The database for #{inspect(repo)} couldn't be created: #{term}")

        {:error, term} ->
          Logger.error("The database for #{inspect(repo)} couldn't be created: #{inspect(term)}")
      end

      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
