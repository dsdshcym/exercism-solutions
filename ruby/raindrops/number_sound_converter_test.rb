require 'minitest/autorun'

require_relative 'number_sound_converter'

class NumberSoundConverterTest < Minitest::Test
  def test_for_returns_empty_if_block_returns_true
    rule = NumberSoundConverter.new('Fizz') do |_number|
      false
    end

    sound = rule.for(2)

    assert_equal '', sound
  end

  def test_for_number_dividable_by_factor_is_sound
    rule = NumberSoundConverter.new('Fizz') do |_number|
      true
    end

    sound = rule.for(3)

    assert_equal 'Fizz', sound
  end
end
