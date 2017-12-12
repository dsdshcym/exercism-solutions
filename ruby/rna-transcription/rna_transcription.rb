class Complement
  def self.of_dna(dna)
    new(dna).to_s
  end

  def initialize(dna)
    @dna = dna
  end

  def to_s
    if dna_valid?
      dna_nucleotides
        .map { |char| rna_complement(char) }
        .join
    else
      ''
    end
  end

  def rna_complement(char = nil)
    case char
    when 'C' then 'G'
    when 'G' then 'C'
    when 'T' then 'A'
    when 'A' then 'U'
    else ''
    end
  end

  private

  attr_reader :dna

  def dna_nucleotides
    dna.chars
  end

  def dna_valid?
    dna_nucleotides.all? { |nucleotides| %w[G C A T].include?(nucleotides) }
  end
end

module BookKeeping
  VERSION = 4
end
