defmodule Route do
  import Weber.Route
  require Weber.Route

  route on("GET", "/", :ExagotchiServer.Main, :index)
end
