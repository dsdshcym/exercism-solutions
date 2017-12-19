class Squares < Struct.new(:n)
  def difference
    square_of_sum - sum_of_squares
  end

  def square_of_sum
    square(sum(1..n))
  end

  def sum_of_squares
    sum(squares(1..n))
  end

  private

  def sum(enumerable)
    enumerable.reduce(:+)
  end

  def squares(enumerable)
    enumerable.map { |x| square(x) }
  end

  def square(x)
    x * x
  end
end

module BookKeeping
  VERSION = 4
end
