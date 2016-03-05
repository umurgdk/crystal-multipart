require "./parser"
require "./maybe"

abstract class Parsec::CharParser < Parsec::Parser(Char)
    def step(char : Char)
        if test(char)
            @cargo += char
            success
        else
            fail
        end
    end

    def produce
        Maybe.just(@cargo[0])
    end

    abstract def test(char : Char) : Bool
end
