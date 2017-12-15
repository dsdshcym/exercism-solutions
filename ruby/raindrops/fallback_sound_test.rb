require 'minitest/autorun'

require_relative 'fallback_sound'

class FallbackSoundTest < Minitest::Test
  def setup
    @sound = FallbackSound.new
  end

  def test_convertable_always_returns_true
    100.times do |i|
      assert sound.convertable?(i)
    end
  end

  def test_for_always_returns_number_to_s
    100.times do |i|
      assert_equal i.to_s, sound.for(i)
    end
  end

  private

  attr_reader :sound
end
