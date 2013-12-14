defmodule ExagotchiServer.Main do
  use Weber.Controller
  import Weber.Session

  require IEx

  layout false

  def index([], conn) do
    creature = get_creature(conn) || spawn_creature(conn)
    IO.inspect creature
    stats = Exagotchi.Creature.get_stats(creature)
    {:render, [age: stats[:age]], []}
  end

  def spawn_creature(conn) do
    {:ok, pid} = Exagotchi.Creature.spawn
    set_session_val(conn, :creature, pid)
    pid
  end

  def get_creature(conn) do
    response = get_session(conn, :creature)
    case response do
      [] -> false
      _  -> response
    end
  end
end
