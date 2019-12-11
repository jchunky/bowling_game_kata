require 'ostruct'

class BowlingGame
  MAX_POINTS_PER_TURN = 10
  MAX_TURNS = 10

  def initialize
    @rolls = []
  end

  def roll(points)
    @rolls << points
  end

  def score
    @score = 0
    @roll_number = 0
    @turn = 0
    @turn_scores = Array.new(MAX_POINTS_PER_TURN, 0)
    @spare = false
    @strikes = []
    @bonus_rolls = 0
    @rolls.each do |points|
      break if @turn == MAX_TURNS

      @score += points
      @turn_scores[@turn] += points
      if @spare
        @score += points
        @turn_scores[(@turn - 1)] += points
        @spare = false
      end

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
          if points == MAX_POINTS_PER_TURN
          else
            @roll_number = @roll_number.zero? ? 1 : 0
          end
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

    @score
  end
end
