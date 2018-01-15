class Sieve
  attr_reader :primes

  def initialize(limit)
    @primes = generate_primes_upto(limit)
  end

  private

  def generate_primes_upto(limit)
    sieve = 2.upto(limit).to_a

    2.upto(limit).each do |prime|
      next unless sieve.include?(prime)

      sieve.reject! { |number| number != prime && (number % prime).zero? }
    end

    sieve
  end
end

module BookKeeping
  VERSION = 1
end
