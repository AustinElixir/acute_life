defmodule AcuteLifeTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  alias Tentacat.Repositories

  defmodule TestRepositories do
    def list_users(user) do
      [%{"full_name" => "#{user}/intellij-elixir"}]
    end
  end

  setup do
    repositories_module = if System.get_env("INTEGRATION") == "true" do
      Repositories
    else
      TestRepositories
    end

    [repositories_module: repositories_module]
  end

  describe "main/1" do
    test "without arguments it prints usage" do
      assert capture_io(
        fn ->
          AcuteLife.main([])
        end
      ) == "Usage: acute_life repositories USER\n"
    end

    test "with repositories USER lists repositories", %{repositories_module: repositories_module} do
      user = "KronicDeth"
      output = capture_io(
        fn ->
          AcuteLife.main(["repositories", user], repositories_module)
        end
      )
      IO.puts output
      assert "#{user}/intellij-elixir" in String.split(output, "\n")
    end
  end
end
