module Sgf2Img
  class Sgf
    attr_reader :size
    attr_reader :board

    def initialize(sgfstring)
      parse sgfstring
    end

  private
    def parse sgfstring
      sgfstring.strip!
      sgfstring = sgfstring.chop if sgfstring[sgfstring.length - 1, 1] == ')'
      parts = sgfstring.split ';'
      parse_params parts[1]
      parse_moves parts[2, parts.length - 2].join('')
    end

    def parse_params paramsstring
      whitestones = []
      blackstones = []
      parse_sgf_commands(paramsstring).each do |p|
        case p[:n]
         when 'SZ'
           @size = p[:v][0].to_i
         when 'AW'
           whitestones = p[:v]
         when 'AB'
           blackstones = p[:v]
        end
      end
      init_board
      whitestones.each { |pos| set_board_position pos, 'W' }
      blackstones.each { |pos| set_board_position pos, 'B' }
    end

    def init_board
      @board = []
      (0..(@size-1)).each { |i| @board[i] = [] }
    end

    def parse_moves moves_string
      parse_sgf_commands(moves_string).each do |p|
        color = p[:n]
        position = p[:v][0]
        set_board_position(position, color) if color == 'B' || color == 'W'
      end
    end

    def set_board_position pos, color
      x = pos.downcase[1] - 'a'[0]
      y = pos.downcase[0] - 'a'[0]
      init_board if @board.nil?
      @board[x][y] = color
    end

    def parse_sgf_commands commands_string
      paramRE = /([A-Z]+)((\[[^\]]+\])+)/
      result = []
      while match = paramRE.match(commands_string)
        m = match.to_s
        commands_string = commands_string[m.length, commands_string.length].strip
        n = match.captures[0]
        v = parse_values match.captures[1]
        result << { :n => n, :v => v }
      end
      result
    end

    def parse_values string
      string[1, string.length - 2].split ']['
    end
  end
end
