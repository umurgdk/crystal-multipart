require "./parser"
require "./maybe"

class Parsec::Plus(T,U) < Parsec::Parser(Array(T | U))
    def initialize(@parser1 : Parsec::Parser(T), @parser2 : Parsec::Parser(U))
        super()
        @current_parser = @parser1
        @sub_cargo = ""
        @products = [] of T | U
    end

    def step(char : Char)
        @cargo += char

        if @sub_cargo.size > 0
            reader = Char::Reader.new(@sub_cargo)

            while reader.has_next?
                break unless sub_step(reader.current_char)
                reader.next_char
            end
        end

        sub_step(char)
    end

    def sub_step(char : Char)
        @current_parser.step(char)

        if @current_parser.satisfied?
            collect_product
        elsif @current_parser.failed?
            @sub_cargo = @current_parser.cargo
            @error_message = @current_parser.error_message + " got '#{@sub_cargo}'"
            collect_product(true)
        end
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
                @cargo = ""
            else
                @current_parser = @parser2
            end
            true
        elsif fail_on_nothing
            fail
            false
        end
    end
end
