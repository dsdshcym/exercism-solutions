class Raindrops
  def self.convert(number)
    new.convert(number)
  end

  def initialize
    @sound = RaindropSound::ChainableFactor.new(
      3, 'Pling',
      RaindropSound::ChainableFactor.new(
        5, 'Plang',
        RaindropSound::ChainableFactor.new(
          7, 'Plong'
        )
      )
    )
  end

  def convert(number)
    sound.for(number)
  end

  private

  attr_reader :sound
end

module RaindropSound
  class ChainableFactor
    def initialize(factor, sound, next_sound = Null.new, fallback = Number.new)
      @factor = factor
      @sound = sound
      @next_sound = next_sound
      @fallback = fallback
    end

    def for(number)
      if convertable?(number)
        direct_convert(number)
      else
        fallback_convert(number)
      end
    end

    protected

    def direct_convert(number)
      if dividable?(number)
        sound + next_sound.direct_convert(number)
      else
        next_sound.direct_convert(number)
      end
    end

    def convertable?(number)
      dividable?(number) || next_sound.convertable?(number)
    end

    private

    attr_reader :factor, :sound, :next_sound, :fallback

    def dividable?(number)
      number.modulo(factor).zero?
    end

    def fallback_convert(number)
      fallback.for(number)
    end
  end

  class Null
    def for(_)
      ''
    end

    def direct_convert(_)
      ''
    end

    def convertable?(_)
      false
    end
  end

  class Number
    def for(number)
      number.to_s
    end
  end
end

module BookKeeping
  VERSION = 3
end
