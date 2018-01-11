class Pangram
  class << self
    def pangram?(phrase)
      include_all_alphabets?(phrase.downcase)
    end

    private

    def include_all_alphabets?(phrase)
      ('a'..'z').all? { |alpha| phrase.include?(alpha) }
    end
  end
end

module BookKeeping
  VERSION = 6
end
