class Hamming
  def self.compute(dna_a, dna_b)
    raise ArgumentError if dna_a.length != dna_b.length
    dna_a.chars.zip(dna_b.chars).map do |char_a, char_b|
      if char_a != char_b
        1
      else
        0
      end
    end.sum
  end
end

module BookKeeping
  VERSION = 3
end
