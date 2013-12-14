defmodule PidServer do
  use ExActor,
    exports: :pid_server,
    initial_state: []

  defcall store(pid), state: state do
    uuid = uuid_from_pid(pid)
    state = Keyword.put(state, uuid, pid)
    set_and_reply(state, {:ok, uuid})
  end

  defp uuid_from_pid(pid) do
    :uuid.uuid_to_string(:uuid.get_v1(:uuid.new(self)))
  end
end
