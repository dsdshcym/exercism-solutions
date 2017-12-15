require_relative 'sound_chain'
require_relative 'fallback_sound'

class Raindrops
  def self.convert(number)
    new.for(number)
  end

  def initialize
    @sounds = init_sounds
  end

  def for(number)
    sounds
      .detect { |sound| sound.convertable?(number) }
      .for(number)
  end

  private

  attr_reader :sounds

  def init_sounds
    @sounds = [
      init_sound_chain,
      init_fallback_sound
    ]
  end

  def init_sound_chain
    SoundChain.new(
      [3, 'Pling'],
      [5, 'Plang'],
      [7, 'Plong']
    )
  end

  def init_fallback_sound
    FallbackSound.new
  end
end

module BookKeeping
  VERSION = 3
end
