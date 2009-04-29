describe 'ImageCreator' do
  before do
    @sgfempty3 = Sgf.new "(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]\nRU[Japanese]SZ[3]KM[0.00]\nPW[White]PB[Black]\n)"
    @sgf3 = Sgf.new "(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]\nRU[Japanese]SZ[3]KM[0.00]\nPW[White]PB[Black]\n;B[aa];W[bb])"
  end

  it "should generate the right command for an empty 3x3 board" do
    command = "montage ./top_left.gif ./top_center.gif ./top_right.gif ./center_left.gif ./center_center.gif ./center_right.gif ./bottom_left.gif ./bottom_center.gif ./bottom_right.gif -tile 3x3 -geometry +0+0 -background '#f2b06d' test.gif"
    ic = ImageCreator.new @sgfempty3, '.'
    ic.command('test.gif').should == command
  end

  it "should generate the right command for a 3x3 board with some stones" do
    command = "montage ./black.gif ./top_center.gif ./top_right.gif ./center_left.gif ./white.gif ./center_right.gif ./bottom_left.gif ./bottom_center.gif ./bottom_right.gif -tile 3x3 -geometry +0+0 -background '#f2b06d' test.gif"
    ic = ImageCreator.new @sgf3, '.'
    ic.command('test.gif').should == command
  end

  it "should generate the right command for a 3x3 board with some stones, default filename" do
    command = "montage ./black.gif ./top_center.gif ./top_right.gif ./center_left.gif ./white.gif ./center_right.gif ./bottom_left.gif ./bottom_center.gif ./bottom_right.gif -tile 3x3 -geometry +0+0 -background '#f2b06d' output.gif"
    ic = ImageCreator.new @sgf3, '.'
    ic.command.should == command
  end
end
