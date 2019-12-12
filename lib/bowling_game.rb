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
      if @turn == MAX_TURNS
        break
      end

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
        if strike.count == 2
          strike.counted = true
        end
      end

      if @bonus_rolls.zero?
        if @turn < 9
          if @roll_number.zero? && points == MAX_POINTS_PER_TURN
            @strikes << OpenStruct.new(turn: @turn, count: 0, counted: false)
          end
          if @roll_number == 1 && @turn_scores[@turn] == MAX_POINTS_PER_TURN
            @spare = true
          end
          if points != MAX_POINTS_PER_TURN
            @roll_number = @roll_number.zero? ? 1 : 0
          end
          if @roll_number.zero?
            @turn += 1
          end
        elsif points == MAX_POINTS_PER_TURN && @roll_number.zero?
          @bonus_rolls = 2
        elsif @turn_scores[@turn] == MAX_POINTS_PER_TURN && roll_number == 1
          @bonus_rolls = 1
        else
          @turn += 1
        end
      else
        @bonus_rolls -= 1
        if @bonus_rolls.zero?
          @turn += 1
        end
      end
    end

    @score
  end
end
