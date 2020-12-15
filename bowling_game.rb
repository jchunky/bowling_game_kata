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
    factors = [0] * 100
    frames = [[]]
    rolls.each.with_index do |r, i|
      frames.last << r
      factors[i] += 1 if frames.size <= 10
      if frames.last.sum == 10 && frames.last.one?
        factors[i + 1] += 1
        factors[i + 2] += 1
        frames << []
      elsif frames.last.sum == 10 && frames.last.size == 2
        factors[i + 1] += 1
        frames << []
      elsif frames.last.size == 2
        frames << []
      end
    end
    factors
  end
end
