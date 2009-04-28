describe 'ImageCreator' do
  before do
    @sgfempty3 = Sgf.new "(;GM[1]FF[4]CA[UTF-8]AP[CGoban:3]ST[2]\nRU[Japanese]SZ[3]KM[0.00]\nPW[White]PB[Black]\n)"
  end

  it "should generate the right command for an empty 3x3 board" do
    command = "montage topleft.gif top.gif topright.gif left.gif empty.gif right.gif bottomleft.gif bottom.gif bottomright.gif -tile 3x3 -geometry +0+0 test.gif"
    ic = ImageCreator.new @sgfempty3
    ic.command('test.gif').should == command
  end
end
