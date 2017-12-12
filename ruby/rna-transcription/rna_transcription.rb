require_relative 'nucleic_acid'

class Complement
  def self.of_dna(sequence)
    NucleicAcid::Dna
      .from_str(sequence)
      .to_rna
      .sequence
  end
end
