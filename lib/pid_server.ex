defmodule PidServer do
  use ExActor,
    export: :pid_server,
    initial_state: []

  defcall store(pid), state: state do
    uuid = uuid_from_pid(pid)
    state = Keyword.put(state, uuid, pid)
    set_and_reply(state, {:ok, uuid})
  end

  defcall fetch(uuid), state: state, do: pid_from_uuid(state, uuid)

  defcast each(fun), state: state do
    Enum.map(state, fn {uuid, pid} -> fun.(pid) end)
  end

  defp uuid_from_pid(pid) do
    uuid = :uuid.uuid_to_string(:uuid.get_v1(:uuid.new(self)))
    list_to_atom(uuid)
  end

  defp pid_from_uuid(state, uuid) when is_list(uuid) do
    pid_from_uuid(state, list_to_existing_atom(uuid))
  end
  defp pid_from_uuid(state, uuid) when is_binary(uuid) do
    pid_from_uuid(state, binary_to_existing_atom(uuid))
  end
  defp pid_from_uuid(state, uuid) when is_atom(uuid) do
    Keyword.get(state, uuid)
  end
end
