class ChainableSound
  def self.chain(rule)
    new(StringRule.new, nil).chain(rule)
  end

  def initialize(rule, fallback)
    @rule = rule
    @fallback = fallback
  end

  def for(number)
    if rule.convertable?(number)
      rule.convert(number)
    else
      fallback.for(number)
    end
  end

  def chain(rule)
    self.class.new(rule, self)
  end

  private

  attr_reader :rule, :fallback
end

class StringRule
  def convertable?(_)
    true
  end

  def convert(number)
    number.to_s
  end
end
