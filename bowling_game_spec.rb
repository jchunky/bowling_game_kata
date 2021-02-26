require_relative "bowling_game"

RSpec.describe BowlingGame do
  it "works" do
    expect(score([10] * 9 + [1, 2])).to eq(247)
    expect(score([10] * 10 + [1, 2])).to eq(274)
    expect(score([10] * 12)).to eq(300)

    expect(to_s(8, 2, 5, 4, 9, 0, 10, 10, 5, 5, 5, 3, 6, 3, 9, 1, 9, 1, 10)).to eq(<<~SCORE.strip)
      1) [8, 2] +15 =15
      2) [5, 4] +9 =24
      3) [9, 0] +9 =33
      4) [10] +25 =58
      5) [10] +20 =78
      6) [5, 5] +15 =93
      7) [5, 3] +8 =101
      8) [6, 3] +9 =110
      9) [9, 1] +19 =129
      10) [9, 1, 10] +20 =149
    SCORE
  end

  def score(rolls)
    BowlingGame.new(*rolls).score
  end

  def to_s(*rolls)
    BowlingGame.new(*rolls).to_s
  end
end
