require "./parser"
require "./maybe"

class Parsec::NumberOf(T) < Parsec::Parser(Array(T))
    def initialize(@parser : Parsec::Parser(T), @expected_count : Int)
        super()
        @error_message = "At least one #{parser.error_message}"
        @parsed_count = 0
        @products = [] of T
    end

    def step(char : Char)
        @parser.step(char)

        if @parser.failed? && @parsed_count != @expected_count
            fail
        elsif @parser.failed? && @parsed_count == @expected_count
            success
        elsif @parser.satisfied?
            product = @parser.produce
            if product.is_a?(Maybe::Just(T))
                @products << product.content
            end

            if @parsed_count == @expected_count
                success
            end

            @parser.reset
        end

        @cargo += char
    end

    def produce
        Maybe.just(@products)
    end
end

