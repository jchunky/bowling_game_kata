class Frame < Struct.new(:number, :rolls, :subsequent_rolls, :previous_total_score)
  def to_s
    format(
      "Frame %02i: %-3s    Frame Score: %2i    Total Score: %3i",
      number,
      rolls.map.with_index(&method(:format_roll)).join,
      score,
      total_score
    )
  end

  def score
    result = rolls.sum
    result += subsequent_rolls.take(2).sum if strike?
    result += subsequent_rolls.take(1).sum if spare?
    result
  end

  private

  def format_roll(roll, index)
    return "X" if roll == 10
    return "-" if roll == 0
    return "/" if index == 1 && rolls.sum == 10 && number != 10
    return "/" if index == 2 && rolls[1..2].sum == 10 && number == 10

    roll
  end

  def total_score
    score + previous_total_score
  end

  def strike?
    rolls.sum == 10 && rolls.count == 1
  end

  def spare?
    rolls.sum == 10 && rolls.count == 2
  end
end

class BowlingGame
  attr_reader :rolls

  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  def description
    frames.join("\n")
  end

  def score
    frames.sum(&:score)
  end

  private

  def frames
    @frames ||= begin
      tmp_rolls = rolls.dup
      frame_number = 1
      result = []
      current_total_score = 0
      while tmp_rolls.any?
        rolls = []
        rolls << tmp_rolls.shift
        rolls << tmp_rolls.shift if rolls.sum != 10 && tmp_rolls.any?
        rolls << tmp_rolls.shift while tmp_rolls.any? if frame_number == 10
        subsequent_rolls = tmp_rolls.dup
        current_frame = Frame.new(frame_number, rolls, subsequent_rolls, current_total_score)
        result << current_frame
        current_total_score += current_frame.score
        frame_number += 1
      end
      result
    end
  end
end