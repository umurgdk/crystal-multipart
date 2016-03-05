require "./parser"

class Parsec::StringParser < Parsec::Parser(String)
    def initialize(@expectedString)
        super()
        @error_message = "expected string '#{@expectedString}'"
    end

    def step(char : Char)
        @cargo += char

        if @cargo == @expectedString
            success
        elsif @cargo.size >= @expectedString.size
            fail
        end
    end

    def produce
        Maybe.just(@cargo)
    end
end
