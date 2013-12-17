# Just a module to spawn for kicks
defmodule FakeServer do
  def start do
  end
end

defmodule PidStorageTest do
  use ExUnit.Case

  setup do
    {:ok, _} = PidServer.start
    :ok
  end

  test "storing a pid", meta do
    pid = spawn(FakeServer, :start, [])
    {:ok, uuid} = PidServer.store(pid)
    assert is_atom(uuid)
    assert PidServer.fetch(uuid) == pid
  end
end
