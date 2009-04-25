module Sgf2Img
  class Sgf
    attr_reader :size

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
      paramRE = /([A-Z]+)\[([^\]]+)\]/
      while match = paramRE.match(paramsstring)
        m = match.to_s
        paramsstring = paramsstring[m.length, paramsstring.length].strip
        p = match.captures[0]
        v = match.captures[1]
        @size = v.to_i if p == 'SZ'
      end
    end

    def parse_moves moves_string
      # Nothing yet
    end
  end
end
