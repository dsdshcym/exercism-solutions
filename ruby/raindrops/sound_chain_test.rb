require 'minitest/autorun'

require_relative 'sound_chain'

class SoundChainTest < Minitest::Test
  def setup
    @sound = SoundChain.new(
      [3, 'Fizz'],
      [5, 'Buzz'],
      [7, 'Whizz']
    )
  end

  def test_convertable_for_number_can_be_divided_by_the_first_factor_is_true
    assert sound.convertable?(3)
  end

  def test_convertable_for_number_can_be_divided_by_the_second_factor_is_true
    assert sound.convertable?(35)
  end

  def test_convertable_for_number_can_be_divided_by_the_third_factor_is_true
    assert sound.convertable?(49)
  end

  def test_for_number_only_dividable_by_the_first_factor_is_the_first_sound
    assert_equal 'Fizz', sound.for(6)
  end

  def test_for_number_only_dividable_by_the_second_factor_is_the_second_sound
    assert_equal 'Buzz', sound.for(10)
  end

  def test_for_number_only_dividable_by_the_third_factor_is_the_third_sound
    assert_equal 'Whizz', sound.for(28)
  end

  def test_for_number_dividable_by_both_factors_is_the_concatenation_of_sounds
    assert_equal 'FizzBuzz', sound.for(15)
  end

  def test_for_number_dividable_by_all_factors_is_the_concatenation_of_sounds
    assert_equal 'FizzBuzzWhizz', sound.for(105)
  end

  private

  attr_reader :sound
end
