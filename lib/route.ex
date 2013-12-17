defmodule Route do
  import Weber.Route
  require Weber.Route

  route on("GET", "/",     :ExagotchiServer.Main, :index)
     |> on("GET", "/feed", :ExagotchiServer.Main, :feed)
     |> on("GET", "/play", :ExagotchiServer.Main, :play)
end
