defmodule QueueAppTest do
  use ExUnit.Case
  doctest QueueApp

  test "greets the world" do
    assert QueueApp.hello() == :world
  end
end
