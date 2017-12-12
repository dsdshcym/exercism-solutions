require_relative 'nucleotide'

module NucleicAcid
  class Base
    def self.from_str(string)
      new(string.chars.map { |char| Nucleotide.from_abbreviation(char) })
    end

    def initialize(nucleotides)
      @nucleotides = nucleotides
    end

    def sequence
      if valid?
        nucleotides.map(&:abbreviation).join
      else
        ''
      end
    end

    private

    attr_reader :nucleotides

    def valid?
      nucleotides.all?(&:valid?)
    end
  end

  class Dna < Base
    def to_rna
      Rna.new(nucleotides.map(&:complement_in_rna))
    end
  end

  class Rna < Base
  end
end
