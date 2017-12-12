class Raindrops
  def self.convert(number)
    ans = ''
    ans += 'Pling' if number.modulo(3).zero?
    ans += 'Plang' if number.modulo(5).zero?
    ans += 'Plong' if number.modulo(7).zero?

    ans.empty? ? number.to_s : ans
  end
end

module BookKeeping
  VERSION = 3
end
