require "./parser"

class Parsec::StringParser < Parsec::Parser(String)
    def initialize(@expectedString)
        super()
        @index = 0
        @error_message = "expected string '#{@expectedString}'"
    end

    def step(char : Char)
        @cargo += char

        if @cargo == @expectedString
            success
        elsif @cargo.size >= @expectedString.size
            fail
        elsif @expectedString[@index] != @cargo[@index]
            fail
        end
    end

    def produce
        if @cargo == @expectedString
            Maybe.just(@cargo)
        else
            Maybe(String).nothing
        end
    end
end
