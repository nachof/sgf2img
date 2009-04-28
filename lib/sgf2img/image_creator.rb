module Sgf2Img
  class ImageCreator
    def initialize sgf
      @sgf = sgf
    end

    def command output_file
      c = "montage "
      (0..(@sgf.size-1)).each do |i|
        (0..(@sgf.size-1)).each do |j|
          c += empty_for i, j
        end
      end
      c += "-tile #{@sgf.size}x#{@sgf.size} -geometry +0+0 #{output_file}"
    end

  private
    def empty_for i, j
      if j == 0
        if i == 0
          return 'topleft.gif '
        elsif i == @sgf.size - 1
          return 'bottomleft.gif '
        else
          return 'left.gif '
        end
      elsif j == @sgf.size - 1
        if i == 0
          return 'topright.gif '
        elsif i == @sgf.size - 1
          return 'bottomright.gif '
        else
          return 'right.gif '
        end
      else
        if i == 0
          return 'top.gif '
        elsif i == @sgf.size - 1
          return 'bottom.gif '
        else
          return 'empty.gif '
        end
      end
    end
  end
end
