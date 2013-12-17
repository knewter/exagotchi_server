defmodule ExagotchiServer do

  require Weber.Templates.ViewsLoader

  def start(_type, _args) do
    # Set resources
    Weber.Templates.ViewsLoader.set_up_resources(File.cwd!)
    # compile all views
    Weber.Templates.ViewsLoader.compile_views(File.cwd!)
    PidServer.start
    spawn(__MODULE__, :age_every_creature_every_second, [])
    # start weber application
    Weber.run_weber
  end

  def stop(_state) do
    :ok
  end

  def age_every_creature_every_second do
    :timer.sleep(1000)
    PidServer.each(fn(pid) -> Exagotchi.Creature.age(pid) end)
    age_every_creature_every_second
  end
end
