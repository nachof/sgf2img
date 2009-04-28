describe 'ImageCreator' do
  before do
    @sgfempty3 = Sgf.new "(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]\nRU[Japanese]SZ[3]KM[0.00]\nPW[White]PB[Black]\n)"
    @sgf3 = Sgf.new "(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]\nRU[Japanese]SZ[3]KM[0.00]\nPW[White]PB[Black]\n;B[aa];W[bb])"
  end

  it "should generate the right command for an empty 3x3 board" do
    command = "montage topleft.gif top.gif topright.gif left.gif empty.gif right.gif bottomleft.gif bottom.gif bottomright.gif -tile 3x3 -geometry +0+0 test.gif"
    ic = ImageCreator.new @sgfempty3
    ic.command('test.gif').should == command
  end

  it "should generate the right command for a 3x3 board with some stones" do
    command = "montage black.gif top.gif topright.gif left.gif white.gif right.gif bottomleft.gif bottom.gif bottomright.gif -tile 3x3 -geometry +0+0 test.gif"
    ic = ImageCreator.new @sgf3
    ic.command('test.gif').should == command
  end
end
