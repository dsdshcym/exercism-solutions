defmodule Tournament do
  @title ~w/Team MP W D L P/

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> parse()
    |> calc_match_statistics()
    |> as_table()
  end

  defp parse(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
  end

  defp calc_match_statistics(matches) do
    for [team1, team2, match_result] <- matches do
      case match_result do
        "win" ->
          %{team1 => %{mp: 1, w: 1, d: 0, l: 0, p: 3},
            team2 => %{mp: 1, w: 0, d: 0, l: 1, p: 0}}
        "loss" ->
          %{team1 => %{mp: 1, w: 0, d: 0, l: 1, p: 0},
            team2 => %{mp: 1, w: 1, d: 0, l: 0, p: 3}}
        "draw" ->
          %{team1 => %{mp: 1, w: 0, d: 1, l: 0, p: 1},
            team2 => %{mp: 1, w: 0, d: 1, l: 0, p: 1}}
        _ -> %{}
      end
    end
    |> Enum.reduce(%{}, fn(match, result) ->
      Map.merge(match, result, fn(_k, statistics1, statistics2) ->
        Map.merge(statistics1, statistics2, fn(_k, count1, count2) -> count1 + count2 end)
      end)
    end)
  end

  defp as_table(statistics) do
    columns =
      statistics
      |> Enum.sort_by(fn({team, statistic}) -> [-statistic.p, team] end)
      |> Enum.map(fn({team, statistic}) -> [team, statistic.mp, statistic.w, statistic.d, statistic.l, statistic.p] end)

    [@title | columns]
    |> Enum.map(&format_row/1)
    |> Enum.join("\n")
  end

  defp format_row([team, mp, w, d, l, p]) do
    [pad_team(team), pad_number(mp), pad_number(w), pad_number(d), pad_number(l), pad_number(p)]
    |> Enum.join(" | ")
  end

  defp pad_team(team), do: String.pad_trailing("#{team}", 30)
  defp pad_number(team), do: String.pad_leading("#{team}", 2)
end
