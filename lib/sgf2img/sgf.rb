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
      parse_moves parts[2]
    end

    def parse_params paramsstring
      parse_sgf_commands(paramsstring).each do |p|
        @size = p[:v].to_i if p[:n] == 'SZ'
      end
    end

    def parse_moves moves_string
      @board = []
      (0..(@size-1)).each { |i| @board[i] = [] }
      parse_sgf_commands(moves_string).each do |m|
        set_board_position(m[:v], m[:n])
      end
    end

    def set_board_position pos, color
      x = pos.downcase[0] - 'a'[0]
      y = pos.downcase[1] - 'a'[0]
      @board[x][y] = color
    end

    def parse_sgf_commands commands_string
      paramRE = /([A-Z]+)\[([^\]]+)\]/
      result = []
      while match = paramRE.match(commands_string)
        m = match.to_s
        commands_string = commands_string[m.length, commands_string.length].strip
        n = match.captures[0]
        v = match.captures[1]
        result << { :n => n, :v => v }
      end
      result
    end
  end
end
