require "./char_parser"

class Parsec::Digit < Parsec::CharParser
    def initialize(@error_message = "Expected digit")
        super()
    end

    def test(char : Char)
        char.digit?
    end
end
