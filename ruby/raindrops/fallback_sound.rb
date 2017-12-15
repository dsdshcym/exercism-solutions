require_relative 'number_sound_converter'

class FallbackSound < NumberSoundConverter
  def initialize
    super(nil) do |_number|
      true
    end
  end

  def for(number)
    number.to_s
  end
end
