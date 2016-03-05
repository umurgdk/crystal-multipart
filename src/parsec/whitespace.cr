require "./char_parser.cr"

class Parsec::Whitespace < Parsec::CharParser
    def initialize(@error_message = "expected whitespace")
        super()
    end

    def test(char : Char)
        char.whitespace?
    end
end
