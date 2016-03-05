require "./char_parser"

class Parsec::Letter < Parsec::CharParser
    def initialize(@error_message = "Expected letter")
        super()
    end

    def test(char : Char)
        char.alpha?
    end
end
