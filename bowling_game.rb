class BowlingGame
  attr_reader :rolls

  def initialize
    @rolls = []
  end

  def roll(points)
    rolls << points
  end

  def score
    rolls.zip(factors).sum { |r, f| r * f }
  end

  def factors
    result = [0] * 21
    frames = [[]]
    rolls.each_with_index do |roll, i|
      break if frames.size > 10

      frames.last << roll
      result[i] += 1
      if frames.last.sum == 10 && frames.last.size == 1
        result[i + 1] += 1
        result[i + 2] += 1
        frames << []
      elsif frames.last.sum == 10
        result[i + 1] += 1
        frames << []
      elsif frames.last.size == 2
        frames << []
      end
    end
    result
  end
end
