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
  class Base
    def initialize(fallback)
      @fallback = fallback
    end

    def for(number)
      if convertable?(number)
        convert(number)
      else
        fallback.for(number)
      end
    end

    private

    attr_reader :fallback
  end

  class ChainableFactor < Base
    def initialize(factor, sound, next_sound = Null.new, fallback = NumberToString.new)
      @factor = factor
      @sound = sound
      @next_sound = next_sound
      super(fallback)
    end

    protected

    def convert(number)
      if dividable?(number)
        sound + next_sound.convert(number)
      else
        next_sound.convert(number)
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

  class NumberToString < Base
    def initialize
      super(Null.new)
    end

    def for(number)
      number.to_s
    end

    def convertable?(number)
      number.respond_to?(:to_s)
    end
  end

  class Null < Base
    def initialize
      super(nil)
    end

    def for(_)
      ''
    end

    def convert(_)
      ''
    end

    def convertable?(_)
      false
    end
  end
end

module BookKeeping
  VERSION = 3
end
