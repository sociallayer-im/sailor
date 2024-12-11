defmodule SailorWeb.BeatLive do
  use SailorWeb, :live_view

  def render(assigns) do
    ~H"""
    Current value: {@value}°F
    <button phx-click="inc_value">+</button>
    """
  end

  def mount(_params, _session, socket) do
    value = 70 # Let's assume a fixed value for now
    {:ok, assign(socket, :value, value)}
  end

  @spec handle_event(<<_::72>>, any(), map()) :: {:noreply, map()}
  def handle_event("inc_value", _params, socket) do
    IO.puts("inc_value")
    {:noreply, update(socket, :value, &(&1 + 1))}
  end
end
