defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    for nucleotide <- dna, do: to_rna_nucleotide(nucleotide)
  end

  defp to_rna_nucleotide(?G), do: ?C
  defp to_rna_nucleotide(?C), do: ?G
  defp to_rna_nucleotide(?T), do: ?A
  defp to_rna_nucleotide(?A), do: ?U
end
