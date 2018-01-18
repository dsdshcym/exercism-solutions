defmodule PrettyNANP do
  defstruct [:nanp]

  def new(raw) do
    %PrettyNANP{nanp: NANP.new(raw)}
  end
end

defimpl String.Chars, for: PrettyNANP do
  def to_string(%PrettyNANP{
        nanp: %NANP{
          area_code: area_code,
          exchange_code: exchange_code,
          subscriber_number: subscriber_number
        }
      }),
      do: "(#{area_code}) #{exchange_code}-#{subscriber_number}"

  def to_string(_), do: "(000) 000-0000"
end
