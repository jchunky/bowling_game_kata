require_relative "bowling_game"

RSpec.describe BowlingGame do
  it "works" do
    # expect(score([])).to eq(0)
    # expect(score([3])).to eq(3)
    # expect(score([9])).to eq(9)
    # expect(score([10])).to eq(10)
    # expect(score([1, 2])).to eq(3)
    # expect(score([2, 4])).to eq(6)
    # expect(score([1, 9])).to be(10)
    # expect(score([1, 9, 1])).to eq(12)
    # expect(score([10, 1, 2])).to eq(16)
    # expect(score([10, 10, 1])).to eq(33)
    # expect(score([10] * 9 + [1, 2])).to eq(243)
    # expect(score([10] * 10 + [1, 2])).to eq(274)
    # expect(score([10] * 12)).to eq(300)

    expect(score(8, 2, 5, 4, 9, 0, 10, 10, 5, 5, 5, 3, 6, 3, 9, 1, 9, 1, 10)).to eq(<<~SCORE.strip)
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

  def score(*rolls)
    BowlingGame.new(*rolls).to_s
  end
end
