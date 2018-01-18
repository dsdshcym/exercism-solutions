defmodule NANP do
  defstruct valid: false, area_code: "000", exchange_code: "000", subscriber_number: "0000"

  @country_calling_code_regex "(?<country_calling_code>\\+?1\\s*)?"
  @area_code_regex "(?<area_code>[2-9][0-9]{2})"
  @exchange_code_regex "(?<exchange_code>[2-9][0-9]{2})"
  @subscriber_number_regex "(?<subscriber_number>[0-9]{4})"

  @parens_style_regex ~r/^#{@country_calling_code_regex}\(#{@area_code_regex}\) #{
                        @exchange_code_regex
                      }-#{@subscriber_number_regex}$/
  @dot_style_regex ~r/^#{@country_calling_code_regex}#{@area_code_regex}\.#{@exchange_code_regex}\.#{
                     @subscriber_number_regex
                   }$/
  @pure_digits_style_regex ~r/^#{@country_calling_code_regex}#{@area_code_regex}#{
                             @exchange_code_regex
                           }#{@subscriber_number_regex}$/

  def new(raw) do
    raw
    |> maybe_match(@parens_style_regex)
    |> maybe_match(@dot_style_regex)
    |> maybe_match(@pure_digits_style_regex)
    |> maybe_return_invalid()
  end

  defp maybe_match(raw, regex) when is_binary(raw) do
    case Regex.named_captures(regex, raw) do
      nil ->
        raw

      match ->
        %NANP{
          valid: true,
          area_code: match["area_code"],
          exchange_code: match["exchange_code"],
          subscriber_number: match["subscriber_number"]
        }
    end
  end

  defp maybe_match(nanp, _regex), do: nanp

  defp maybe_return_invalid(%NANP{} = nanp), do: nanp
  defp maybe_return_invalid(_), do: %NANP{}
end

defimpl String.Chars, for: NANP do
  def to_string(%NANP{
        area_code: area_code,
        exchange_code: exchange_code,
        subscriber_number: subscriber_number
      }),
      do: "#{area_code}#{exchange_code}#{subscriber_number}"

  def to_string(_), do: "0000000000"
end
