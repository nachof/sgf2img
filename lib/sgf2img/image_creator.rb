module Sgf2Img
  class ImageCreator
    def initialize sgf
      @sgf = sgf
    end

    def command output_file
      c = "montage "
      (0..(@sgf.size-1)).each do |i|
        (0..(@sgf.size-1)).each do |j|
          c += case @sgf.board[i][j]
                 when 'B' then 'black.gif '
                 when 'W' then 'white.gif '
                 else empty_for i, j
               end
        end
      end
      c += "-tile #{@sgf.size}x#{@sgf.size} -geometry +0+0 #{output_file}"
    end

  private
    def empty_for i, j
      "#{vertical i}_#{horizontal j}.gif "
    end

    def vertical i
      case i
        when 0 then 'top'
        when @sgf.size - 1 then 'bottom'
        else 'center'
      end
    end

    def horizontal i
      case i
        when 0 then 'left'
        when @sgf.size - 1 then 'right'
        else 'center'
      end
    end
  end
end
