require_relative 'factor_rule'
require_relative 'chainable_sound'

class Raindrops
  def self.convert(number)
    new.convert(number)
  end

  def initialize
    factor_rule = init_factor_rule

    @sound = ChainableSound.chain(factor_rule)
  end

  def convert(number)
    sound.for(number)
  end

  private

  attr_reader :sound

  def init_factor_rule
    FactorRule.new(3, 'Pling').tap do |rule|
      rule
        .chain(5, 'Plang')
        .chain(7, 'Plong')
    end
  end
end

module BookKeeping
  VERSION = 3
end
