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

  it "works" do
    expect(score([])).to eq(0)
    expect(score([9])).to eq(9)
    expect(score([1, 2])).to eq(3)
    expect(score([10] * 12)).to eq(300)
    expect(score([3])).to eq(3)
    expect(score([2, 4])).to eq(6)
    expect(score([1, 2])).to eq(3)
    expect(score([10])).to eq(10)
    expect(score([1, 9])).to be(10)
    expect(score([1, 9, 1])).to eq(12)
    expect(score([1, 9, 1])).to eq(12)
    expect(score([10, 1, 2])).to eq(16)
    expect(score([10, 10, 1])).to eq(33)
    expect(score([10] * 10 + [1, 2])).to eq(274)
    expect(score([10] * 9 + [1, 2])).to eq(243)
  end

  def score(rolls)
    game = BowlingGame.new
    rolls.each { |points| game.roll(points) }
    game.score
  end
end
