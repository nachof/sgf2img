require File.join(File.dirname(__FILE__), '..', 'spec_helper')

include Sgf2Img

describe 'Sgf' do
  before do
    @basic_sgf = '(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]RU[Japanese]SZ[19]KM[0.00]PW[White]PB[Black];B[dd])'
  end

  it "should load a correct sized board" do
    sgf = Sgf.new(@basic_sgf)
    sgf.size.should == 19
  end

  it "should load the right stone" do
    sgf = Sgf.new(@basic_sgf)
    (0..18).each do |i|
      (0..18).each do |j|
        if i == 3 && j == 3
          sgf.board[i][j].should == 'B'
        else
          sgf.board[i][j].should be_nil
        end
      end
    end
  end
end
