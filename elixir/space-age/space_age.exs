defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_day_in_seconds 86400
  @earth_year_in_earth_days 365.25

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds
    |> to_earth_age
    |> to_planet_age(planet)
  end

  defp to_earth_age(seconds), do: seconds |> to_earth_days |> to_earth_years
  defp to_earth_days(seconds), do: seconds / @earth_day_in_seconds
  defp to_earth_years(days), do: days / @earth_year_in_earth_days

  defp to_planet_age(earth_age, :earth), do: earth_age
  defp to_planet_age(earth_age, :mercury), do: earth_age / 0.2408467
  defp to_planet_age(earth_age, :venus), do: earth_age / 0.61519726
  defp to_planet_age(earth_age, :mars), do: earth_age / 1.8808158
  defp to_planet_age(earth_age, :jupiter), do: earth_age / 11.862615
  defp to_planet_age(earth_age, :saturn), do: earth_age / 29.447498
  defp to_planet_age(earth_age, :uranus), do: earth_age / 84.016846
  defp to_planet_age(earth_age, :neptune), do: earth_age / 164.79132
end
