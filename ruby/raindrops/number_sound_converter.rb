class NumberSoundConverter
  def initialize(sound, &block)
    @sound = sound
    @block = block
  end

  def for(number)
    if convertable?(number)
      sound
    else
      ''
    end
  end

  def convertable?(number)
    block.call(number)
  end

  private

  attr_reader :block, :sound
end
