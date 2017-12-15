class FactorRule
  def initialize(factor, sound)
    @factor = factor
    @sound = sound
  end

  def convertable?(number)
    dividable?(number) || fallback.convertable?(number)
  end

  def convert(number)
    if dividable?(number)
      sound + fallback.convert(number)
    else
      fallback.convert(number)
    end
  end

  def chain(*args)
    @fallback = self.class.new(*args)
  end

  private

  attr_reader :factor, :sound

  def dividable?(number)
    number.modulo(factor).zero?
  end

  def fallback
    @fallback ||= NullRule.new
  end
end

class NullRule
  def convertable?(_number)
    false
  end

  def convert(_number)
    ''
  end
end
