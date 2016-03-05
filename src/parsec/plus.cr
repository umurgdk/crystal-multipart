require "./parser"
require "./maybe"

class Parsec::Plus(T,U) < Parsec::Parser(Array(T | U))
    def initialize(@parser1 : Parsec::Parser(T), @parser2 : Parsec::Parser(U))
        super()
        @current_parser = @parser1
        @products = [] of T | U
    end

    def step(char : Char)
        @current_parser.step(char)

        if @current_parser.satisfied?
            collect_product
        elsif @current_parser.failed?
            collect_product(true)
        end

        @cargo += char
    end

    def produce
        if @products.size > 0
            Maybe.just(@products)
        else
            Maybe(Array(U | T)).nothing
        end
    end

    private def collect_product(fail_on_nothing = false)
        product = @current_parser.produce
        if product.is_a?(Maybe::Just)
            @products << product.content

            if @current_parser == @parser2
                success
            else
                @current_parser = @parser2
            end
        elsif fail_on_nothing
            fail
        end
    end
end
