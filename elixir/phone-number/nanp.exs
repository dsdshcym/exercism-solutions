defmodule NANP do
  defstruct valid: false, area_code: "000", exchange_code: "000", subscriber_number: "0000"

  def new(raw) do
    if letter_mixed_in?(raw) do
      %NANP{}
    else
      raw
      |> remove_non_digits()
      |> remove_country_calling_code()
      |> set_parts()
      |> validate_area_code()
      |> validate_exchange_code()
      |> return_invalid_if_nil()
    end
  end

  defp letter_mixed_in?(raw) do
    String.match?(raw, ~r/\p{L}/)
  end

  defp remove_non_digits(raw) do
    raw
    |> String.replace(~r/[^\d]/, "")
  end

  defp remove_country_calling_code("1" <> <<rest::binary-size(10)>>), do: rest
  defp remove_country_calling_code(no_match), do: no_match

  defp set_parts(<<area_code::binary-size(3), exchange_code::binary-size(3), subscriber_number::binary-size(4)>>) do
    %NANP{
      valid: true,
      area_code: area_code,
      exchange_code: exchange_code,
      subscriber_number: subscriber_number
    }
  end
  defp set_parts(_), do: nil

  defp validate_area_code(nanp = %NANP{valid: true, area_code: area_code}) do
    cond do
      String.starts_with?(area_code, "1") -> nil
      String.starts_with?(area_code, "0") -> nil
      true -> nanp
    end
  end
  defp validate_area_code(_), do: nil

  defp validate_exchange_code(nanp = %NANP{valid: true, exchange_code: exchange_code}) do
    cond do
      String.starts_with?(exchange_code, "1") -> nil
      String.starts_with?(exchange_code, "0") -> nil
      true -> nanp
    end
  end
  defp validate_exchange_code(_), do: nil

  defp return_invalid_if_nil(nil), do: %NANP{valid: false}
  defp return_invalid_if_nil(nanp), do: nanp
end

defimpl String.Chars, for: NANP do
  def to_string(
    %NANP{
      area_code: area_code,
      exchange_code: exchange_code,
      subscriber_number: subscriber_number
    }
  ), do: "#{area_code}#{exchange_code}#{subscriber_number}"

  def to_string(_), do: "0000000000"
end
