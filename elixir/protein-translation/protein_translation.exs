defmodule ProteinTranslation do
  @valid_condons ~w(UGU UGC UUA UUG AUG UUU UUC UCU UCC UCA UCG UGG UAU UAC UAA UAG UGA)

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    result = _of_rna(rna)

    if :error in result do
      {:error, "invalid RNA"}
    else
      {:ok, result}
    end
  end

  def _of_rna("") do
    []
  end
  def _of_rna("UAA" <> _remain) do
    []
  end
  def _of_rna("UAG" <> _remain) do
    []
  end
  def _of_rna("UGA" <> _remain) do
    []
  end
  def _of_rna(<< codon :: binary-size(3) >> <> remain) when codon in @valid_condons do
    {:ok, protein} = of_codon(codon)
    [protein | _of_rna(remain)]
  end
  def _of_rna(_invalid_codon) do
    [:error]
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon("UGU"), do: {:ok, "Cysteine"}
  def of_codon("UGC"), do: {:ok, "Cysteine"}
  def of_codon("UUA"), do: {:ok, "Leucine"}
  def of_codon("UUG"), do: {:ok, "Leucine"}
  def of_codon("AUG"), do: {:ok, "Methionine"}
  def of_codon("UUU"), do: {:ok, "Phenylalanine"}
  def of_codon("UUC"), do: {:ok, "Phenylalanine"}
  def of_codon("UCU"), do: {:ok, "Serine"}
  def of_codon("UCC"), do: {:ok, "Serine"}
  def of_codon("UCA"), do: {:ok, "Serine"}
  def of_codon("UCG"), do: {:ok, "Serine"}
  def of_codon("UGG"), do: {:ok, "Tryptophan"}
  def of_codon("UAU"), do: {:ok, "Tyrosine"}
  def of_codon("UAC"), do: {:ok, "Tyrosine"}
  def of_codon("UAA"), do: {:ok, "STOP"}
  def of_codon("UAG"), do: {:ok, "STOP"}
  def of_codon("UGA"), do: {:ok, "STOP"}
  def of_codon(_invalid_codon), do: {:error, "invalid codon"}
end
