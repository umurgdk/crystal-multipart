require "./parser"
require "./maybe"

class Parsec::Or(T,U) < Parsec::Parser(T | U)
    def initialize(@parser1 : Parsec::Parser(T), @parser2 : Parsec::Parser(U))
        super()
        @error_message = "#{@parser1.error_message} or #{@parser2.error_message}"
    end

    def step(char : Char)
        @cargo += char

        step_for_parser(@parser1, char)
        step_for_parser(@parser2, char) unless satisfied?

        if @parser1.failed? && @parser2.failed?
            @error_message += " got: '#{@cargo}'"
            fail
        end
    end

    def step_for_parser(parser, char)
        return if parser.failed?

        parser.step(char)

        if parser.satisfied?
            @cargo = ""
            success
        end
    end

    def produce
        if @parser1.satisfied?
            @parser1.produce
        elsif @parser2.satisfied?
            @parser2.produce
        else
            Maybe(T | U).nothing
        end
    end
end
