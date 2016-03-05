require "./char_parser"

class Parsec::Char < Parsec::CharParser
    def initialize(@expected_char : Char, @error_message = "Unexpected char")
        super()
    end

    def test(char : Char)
        char == @expectedChar
    end
end
