require File.join(File.dirname(__FILE__), '..', 'spec_helper')

include Sgf2Img

describe 'Sgf' do
  before do
    @empty = '(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]RU[Japanese]SZ[19]KM[0.00]PW[White]PB[Black])'
    @basic_sgf = '(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]RU[Japanese]SZ[19]KM[0.00]PW[White]PB[Black];B[dd])'
    @two_moves = "(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]\nRU[Japanese]SZ[19]KM[0.00]\nPW[White]PB[Black]\n;B[dd]\n;W[cc])"
  end

  it "should load a correct sized board" do
    sgf = Sgf.new(@basic_sgf)
    sgf.size.should == 19
  end

  it "should load an empty board" do
    sgf = Sgf.new(@empty)
    sgf.size.should == 19
    (0..18).each do |i|
      (0..18).each do |j|
        sgf.board[i][j].should be_nil
      end
    end
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

  it "should load two stones" do
    sgf = Sgf.new(@two_moves)
    (0..18).each do |i|
      (0..18).each do |j|
        if i == 3 && j == 3
          sgf.board[i][j].should == 'B'
        elsif i == 2 && j == 2
          sgf.board[i][j].should == 'W'
        else
          sgf.board[i][j].should be_nil
        end
      end
    end
  end

  describe "reading an SGF string with set stones at the beginning" do
    before do
      @sgfstring = '(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]RU[Japanese]SZ[9]KM[0.00]PW[White]PB[Black]AW[da][ab][bb][cb][db]AB[eb][gb][ac][bc][cc][dc][ec])'
      @sgf = Sgf.new @sgfstring
    end

    it "should load the size correctly" do
      @sgf.size.should == 9
    end
    it "should have stones in the correct places" do
      @sgf.board[1][1].should == 'W'
      @sgf.board[2][2].should == 'B'
    end
    it "should not have stones in incorrect places" do
      @sgf.board[0][0].should be_nil
    end
  end

  describe "reading a real tsumego" do
    before do
      @example1 = "(;GM[1]FF[4]AP[qGo:1.5.2]ST[1]\nSZ[19]HA[0]KM[5.5]PW[White]PB[Black]\n\n;B[ad];W[ac];B[bd];W[bc];B[cd];W[cc];B[dc];W[db];B[ec];W[jc]\n;B[fc]C[juega negro y mata, la piedra blanca en K17 esta!]\n)"
    end

    it "should read the sgf correctly" do
      sgf = Sgf.new @example1
      sgf.size.should == 19
      sgf.board[0][3].should == 'B'
      sgf.board[0][2].should == 'W'
    end
  end
end
