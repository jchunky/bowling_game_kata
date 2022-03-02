require_relative 'bowling_game'

RSpec.describe BowlingGame do
  it 'works' do
    expect(score([])).to eq(0)
    expect(score([3])).to eq(3)
    expect(score([9])).to eq(9)
    expect(score([10])).to eq(10)
    expect(score([1, 2])).to eq(3)
    expect(score([2, 4])).to eq(6)
    expect(score([1, 9])).to be(10)
    expect(score([1, 9, 1])).to eq(12)
    expect(score([10, 1, 2])).to eq(16)
    expect(score([10, 10, 1])).to eq(33)
    expect(score([10] * 9 + [1, 2])).to eq(247)
    expect(score([10] * 10 + [1, 2])).to eq(274)
    expect(score([10] * 12)).to eq(300)

    description = <<~GAME
       Frame 1: X      Frame Score: 20    Total Score:  20
       Frame 2: 8/     Frame Score: 19    Total Score:  39
       Frame 3: 9/     Frame Score: 18    Total Score:  57
       Frame 4: 8-     Frame Score:  8    Total Score:  65
       Frame 5: X      Frame Score: 29    Total Score:  94
       Frame 6: X      Frame Score: 20    Total Score: 114
       Frame 7: 9/     Frame Score: 19    Total Score: 133
       Frame 8: 9/     Frame Score: 20    Total Score: 153
       Frame 9: X      Frame Score: 29    Total Score: 182
      Frame 10: X9/    Frame Score: 20    Total Score: 202
    GAME
    rolls = [10, 8, 2, 9, 1, 8, 0, 10, 10, 9, 1, 9, 1, 10, 10, 9, 1]
    game = BowlingGame.new

    rolls.each { |points| game.roll(points) }

    expect(game.description.strip).to eq(description.strip)
    expect(game.score).to eq(202)
  end

  def score(rolls)
    game = BowlingGame.new
    rolls.each { |points| game.roll(points) }
    game.score
  end
end
