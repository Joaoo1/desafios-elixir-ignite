defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.Booking

  def generate_report(from_date, to_date, filename \\ "report.csv") do
    booking_list = build_booking_list(from_date, to_date)

    File.write(filename, booking_list)

    {:ok, "Report generated successfully"}
  end

  def build_booking_list(from_date, to_date) do
    BookingsAgent.get_between_range(from_date, to_date)
    |> Map.values()
    |> Enum.map(&booking_string(&1))
  end

  defp booking_string(%Booking{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
