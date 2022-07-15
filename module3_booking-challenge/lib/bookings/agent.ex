defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking))
    {:ok, id}
  end

  def get(user_id), do: Agent.get(__MODULE__, &get_booking(&1, user_id))

  def get_between_range(from_date, to_date) do
    [from_date, to_date]
  end

  defp get_booking(state, user_id) do
    case Map.get(state, user_id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)
end
