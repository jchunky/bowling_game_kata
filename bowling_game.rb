class Frame
  attr_reader :frame_number, :rolls, :bonus_rolls, :starting_score

  def initialize(starting_score, frame_number)
    @starting_score = starting_score
    @frame_number = frame_number
    @rolls = []
    @bonus_rolls = []
  end

  def add_roll(roll)
    rolls << roll
  end

  def add_bonus_rolls(rolls)
    bonus_rolls.concat(rolls)
  end

  def complete?
    rolls.sum == 10 || rolls.size == 2
  end

  def spare?
    rolls.sum == 10 && rolls.size == 2
  end

  def strike?
    rolls.sum == 10 && rolls.size == 1
  end

  def to_s
    "#{frame_number}) [#{rolls_in_frame.join(', ')}] +#{frame_score} =#{total}"
  end

  def rolls_in_frame
    if frame_number == 10
      rolls + bonus_rolls
    else
      rolls
    end
  end

  def total
    starting_score + frame_score
  end

  def frame_score
    rolls.sum + bonus_rolls.sum
  end
end

class BowlingGame
  attr_reader :rolls

  def initialize(*rolls)
    @rolls = rolls
  end

  def to_s
    frames.map(&:to_s).join("\n")
  end

  def score
    frames.last.total
  end

  def frames
    frame_number = 1
    starting_score = 0
    10.times.map do
      frame = Frame.new(starting_score, frame_number)
      frame_number += 1
      frame.add_roll(rolls.shift)
      frame.add_roll(rolls.shift) unless frame.complete?
      frame.add_bonus_rolls(rolls.first(1)) if frame.spare?
      frame.add_bonus_rolls(rolls.first(2)) if frame.strike?
      starting_score = frame.total
      frame
    end
  end
end
