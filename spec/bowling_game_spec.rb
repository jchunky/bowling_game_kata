require "spec_helper"

require_relative "../lib/bowling_game"

RSpec.describe BowlingGame do
  ########################################################
  # Rules of the bowling kata:
  # - 10 turns allowed per game.
  # - 2 rolls allowed per turn.
  # - If bowler fails to knock 10 between 2 rolls, score for that turn is sum of its rolls rolls.
  # - Spare: bowler knocks down 10 on roll #2. Score is 10 + next roll score.
  # - Strike: bowler knocks down 10 on roll #1. Score is 10 + next 2 throw scores.
  # - Spare or strike on last turn (turn 10), gets 1 or 2 bonus rolls respectively. These bonus rolls count toward the 10th turn.
  ########################################################
  #
  # Instructions: Implement a bowling game following the above rules
  # Use practices of: TDD, Arrange-Act-Asset, Red-Green-Refactor

  before(:each) do
    @game = BowlingGame.new
  end

  describe "new game" do
    it "starts with a score of 0" do
      expect(@game.score).to eq(0)
    end

    it "starts on turn 0" do
      expect(@game.turn).to eq(0)
    end

    it "starts on roll_number 0" do
      expect(@game.roll_number).to eq(0)
    end
  end

  describe "score" do
    it "increments on an incomplete roll" do
      rolls = [9]

      score(rolls)

      expect(@game.score).to eq(9)
    end

    it "tracks based on turn" do
      rolls = [1, 2]

      score(rolls)

      expect(@game.turn_scores[0]).to eq(3)
    end

    it "finishes with a perfect game" do
      rolls = [10] * 12

      score(rolls)

      expect(@game.score).to eq(300)
    end
  end

  describe "roll_number" do
    it "increments after each incomplete roll" do
      rolls = [3]

      score(rolls)

      expect(@game.roll_number).to eq(1)
    end

    it "reverts to 0 after consecutive incomplete rolls" do
      rolls = [2, 4]

      score(rolls)

      expect(@game.roll_number).to eq(0)
    end
  end

  describe "turn" do
    it "increments after 2 consecutive incomplete rolls" do
      rolls = [1, 2]

      score(rolls)

      expect(@game.turn).to eq(1)
    end

    it "increments after 1 complete roll" do
      rolls = [10]

      score(rolls)

      expect(@game.turn).to eq(1)
    end
  end

  describe "spare" do
    it "is flagged when 10 is scored between 2 rolls on 1 turn" do
      rolls = [1, 9]

      score(rolls)

      expect(@game.spare).to be(true)
    end

    it "adds extra points to previous turn if spare is flagged" do
      rolls = [1, 9, 1]

      score(rolls)

      expect(@game.turn_scores[0]).to eq(11)
    end

    it "removes spare flag after next roll" do
      rolls = [1, 9, 1]

      score(rolls)

      expect(@game.spare).to eq(false)
    end
  end

  describe "strike" do
    it "adds extra points to previous turn if strike is flagged" do
      rolls = [10, 1, 2]

      score(rolls)

      expect(@game.turn_scores[0]).to eq(13)
    end

    it "handles mutliple strikes" do
      rolls = [10, 10, 1]

      score(rolls)

      expect(@game.turn_scores[0]).to eq(21)
      expect(@game.turn_scores[1]).to eq(11)
    end
  end

  describe "final turn" do
    it "handles extra rolls on final turn" do
      rolls = [10] * 10 + [1, 2]

      score(rolls)

      expect(@game.turn_scores[9]).to eq(13)
    end

    it "returns '@game over' after 10 turns" do
      rolls = [10] * 9 + [1, 2]

      score(rolls)

      expect(@game.roll(1)).to include('game over')
    end
  end

  def score(rolls)
    rolls.each { |points| @game.roll(points) }
  end
end
