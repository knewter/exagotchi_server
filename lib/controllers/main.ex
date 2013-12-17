defmodule ExagotchiServer.Main do
  use Weber.Controller
  import Weber.Session

  require IEx

  layout false

  def index([], conn) do
    creature = get_creature(conn)
    stats  = Exagotchi.Creature.get_stats(creature)
    age    = stats[:age]
    hungry = Exagotchi.Creature.hungry?(creature)
    sad    = Exagotchi.Creature.sad?(creature)
    {:render, [age: age, hungry: hungry, sad: sad], []}
  end

  def feed([], conn) do
    Exagotchi.Creature.feed(get_creature(conn))
    {:redirect, "/"}
  end

  def play([], conn) do
    Exagotchi.Creature.play(get_creature(conn))
    {:redirect, "/"}
  end

  def spawn_creature(conn) do
    {:ok, pid} = Exagotchi.Creature.spawn
    {:ok, uuid} = PidServer.store(pid)
    set_session_val(conn, :creature, uuid)
    pid
  end

  def get_creature(conn) do
    uuid = get_session(conn, :creature)
    case uuid do
      [] -> spawn_creature(conn)
      _  -> PidServer.fetch(uuid)
    end
  end
end
