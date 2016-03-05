require "./parser"
require "./maybe"

class Parsec::Many(T) < Parsec::Parser(Array(T))
    def initialize(@parser : Parsec::Parser(T))
        super()
        @error_message = "At least one #{parser.error_message}"
        @parsed_count = 0
        @products = [] of T
    end

    def step(char : Char)
        @parser.step(char)
        @cargo += char

        if @parser.failed? && @parsed_count == 0
            fail
        elsif @parser.failed?
            success
        elsif @parser.satisfied?
            @cargo = ""
            product = @parser.produce
            if product.is_a?(Maybe::Just(T))
                @products << product.content
            end

            @parser.reset
        end
    end

    def produce
        Maybe.just(@products)
    end
end
