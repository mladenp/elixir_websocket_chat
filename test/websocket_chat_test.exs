defmodule WebsocketChatTest do
  use ExUnit.Case
  doctest WebsocketChat

  test "greets the world" do
    assert WebsocketChat.hello() == :world
  end
end
