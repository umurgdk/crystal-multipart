require "./char_parser"

class Parsec::AlphaNumeric < Parsec::CharParser
    def initialize(@error_message = "Expected alphanumeric")
        super()
    end

    def test(char : Char)
        return char.alphanumeric?
    end
end
