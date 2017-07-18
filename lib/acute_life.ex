defmodule AcuteLife do
  @moduledoc """
  Retrieve user repositories using `Tentacat.Repositories`
  """

  alias Tentacat.Repositories

  def main(argv, repositories_module \\ Repositories)

  def main([], _) do
    IO.puts "Usage: acute_life repositories USER"
  end

  def main(["repositories", user], repositories_module) do
    user
    |> repositories_module.list_users()
    |> Stream.map(
         fn repository ->
           repository["full_name"]
         end
       )
    |> Enum.intersperse("\n")
    |> IO.puts()
  end
end
