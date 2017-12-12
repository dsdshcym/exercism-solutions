class Complement
  def self.of_dna(sequence)
    new(sequence).to_s
  end

  def initialize(sequence)
    @dna = Dna.new(sequence)
  end

  def to_s
    dna.complement_rna.to_s
  end

  private

  attr_reader :dna
end

class Dna
  VALID_NUCLEOTIDES = %w[G C A T].freeze
  NUCLEOTIDES_COMPLEMENT = {
    'C' => 'G',
    'G' => 'C',
    'T' => 'A',
    'A' => 'U'
  }.freeze

  def initialize(sequence)
    @nucleotides = sequence.chars
  end

  def complement_rna
    return '' unless valid?

    nucleotides
      .map { |nucleotide| rna_complement(nucleotide) }
      .join
  end

  def rna_complement(nucleotide = nil)
    NUCLEOTIDES_COMPLEMENT.fetch(nucleotide, '')
  end

  private

  attr_reader :nucleotides

  def valid?
    nucleotides.all? { |nucleotides| VALID_NUCLEOTIDES.include?(nucleotides) }
  end
end

module BookKeeping
  VERSION = 4
end
