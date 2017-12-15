require_relative 'number_sound_converter'

class SoundChain
  def initialize(*args)
    @rules = init_rules(args)
  end

  def convertable?(number)
    rules.any? { |rule| rule.convertable?(number) }
  end

  def for(number)
    sounds(number).join
  end

  private

  attr_reader :rules

  def sounds(number)
    rules.map { |rule| rule.for(number) }
  end

  def init_rules(args)
    args.reduce([]) do |rules, arg|
      rules << NumberSoundConverter.new(arg[1]) do |number|
        number.modulo(arg[0]).zero?
      end
    end
  end
end
