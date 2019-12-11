require 'ostruct'

class BowlingGame
  MAX_POINTS_PER_TURN = 10
  MAX_TURNS = 10
  attr_reader :roll_number, :turn, :turn_scores, :spare

  def initialize
    @rolls = []
  end

  def roll(points)
    @rolls << points
    score
  end

  def score
    @score = 0
    @roll_number = 0
    @turn = 0
    @turn_scores = Array.new(MAX_POINTS_PER_TURN, 0)
    @spare = false
    @strikes = []
    @bonus_rolls = 0
    @rolls.each { |roll| score_roll(roll) }
    @score
  end

  private

  def score_roll(points)
    return 'game over' if @turn == MAX_TURNS

    @score += points
    @turn_scores[@turn] += points
    add_spare_points(points) if @spare

    @strikes.each do |strike|
      if !strike.counted
        @score += points
        @turn_scores[strike.turn] += points
        strike.count += 1
      end

      !strike.counted = true if strike.count == 2
    end unless @strikes.empty?

    if @bonus_rolls.zero?
      if @turn < 9
        @strikes << OpenStruct.new(turn: @turn, count: 0, counted: false) if @roll_number.zero? && points == MAX_POINTS_PER_TURN
        @spare = true if @roll_number == 1 && @turn_scores[@turn] == MAX_POINTS_PER_TURN
        increment_roll_number(points)
        @turn += 1 if @roll_number.zero?
      elsif points == MAX_POINTS_PER_TURN && @roll_number.zero?
        @bonus_rolls = 2
      elsif @turn_scores[@turn] == MAX_POINTS_PER_TURN && roll_number == 1
        @bonus_rolls = 1
      else
        @turn += 1
      end
    else
      @bonus_rolls -= 1
      @turn += 1 if @bonus_rolls.zero?
    end
  end

  def add_spare_points(points)
    @score += points
    @turn_scores[(@turn - 1)] += points
    @spare = false
  end

  def increment_roll_number(points)
    return if points == MAX_POINTS_PER_TURN

    @roll_number = @roll_number.zero? ? 1 : 0
  end
end
