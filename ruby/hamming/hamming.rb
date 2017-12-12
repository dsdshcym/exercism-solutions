class Hamming
  def self.compute(dna_a, dna_b)
    new(dna_a, dna_b).distance
  end

  def initialize(dna_a, dna_b)
    raise ArgumentError if dna_a.length != dna_b.length

    @dna_a_chars = dna_a.chars
    @dna_b_chars = dna_b.chars
  end

  def distance
    diff_array.sum
  end

  private

  attr_reader :dna_a_chars, :dna_b_chars

  def dna_pairs
    dna_a_chars.zip(dna_b_chars)
  end

  def diff_array
    dna_pairs.map { |a, b| a == b ? 0 : 1 }
  end
end

module BookKeeping
  VERSION = 3
end
