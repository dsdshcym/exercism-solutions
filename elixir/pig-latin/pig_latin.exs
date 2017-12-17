defmodule PigLatin do
  @vowels ~w(a e i o u)
  @vowel_groups ~w(yt xr)
  @consonant_groups ~w(ch qu squ th thr sch)

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word = <<vowel::binary-size(1), _rest::binary>>) when vowel in @vowels do
    vowel_rule(word)
  end

  defp translate_word(word = <<vowel_group::binary-size(2), _rest::binary>>) when vowel_group in @vowel_groups do
    vowel_rule(word)
  end

  defp translate_word(word = <<consonant::binary-size(1), _rest::binary>>) when consonant not in @vowels do
    consonant_rule(word)
  end

  defp vowel_rule(word), do: word <> "ay"

  defp consonant_rule(word), do: sink_consonants(word) <> "ay"

  # NOTE: It's possible that sink_consonants runs into a infinite loop
  # if we pass in a word that only contains consonants
  defp sink_consonants(<<consonant_group::binary-size(2), rest::binary>>) when consonant_group in @consonant_groups do
    sink_consonants(rest <> consonant_group)
  end
  defp sink_consonants(<<consonant::binary-size(1), rest::binary>>) when consonant not in @vowels do
    sink_consonants(rest <> consonant)
  end
  defp sink_consonants(word), do: word
end
