require "./char_parser"

class Parsec::Any < Parsec::CharParser
    def initialize(@error_message = "")
        super()
    end

    def test(char : Char)
        true
    end
end
