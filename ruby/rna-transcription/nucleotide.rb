require 'singleton'

module Nucleotide
  def self.from_abbreviation(char)
    ABBREVIATION_TO_CLASS.fetch(char, Invalid).instance
  end

  class Base
    include Singleton

    def valid?
      true
    end

    def abbreviation
      ABBREVIATION_TO_CLASS.key(self.class)
    end

    def complement_in_rna
      RNA_COMPLEMENT.fetch(self.class, Invalid).instance
    end
  end

  class Adenine < Base
  end

  class Cytosine < Base
  end

  class Guanine < Base
  end

  class Thymine < Base
  end

  class Uracil < Base
  end

  class Invalid < Base
    def valid?
      false
    end
  end

  ABBREVIATION_TO_CLASS = {
    'A' => Adenine,
    'C' => Cytosine,
    'G' => Guanine,
    'T' => Thymine,
    'U' => Uracil
  }.freeze

  RNA_COMPLEMENT = {
    Adenine => Uracil,
    Cytosine => Guanine,
    Guanine => Cytosine,
    Thymine => Adenine
  }.freeze
end

module BookKeeping
  VERSION = 4
end
