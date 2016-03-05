require "char/reader"
require "./parsec/parser"

module Parsec
    def self.run_parser(parser : Parser, content : String)
        reader = Char::Reader.new(content)
        next_char = reader.current_char

        while reader.has_next?
            parser.step(next_char)

            if parser.failed? || parser.satisfied?
                break
            end

            next_char = reader.next_char
        end

        if parser.failed?
            raise Exception.new(parser.error_message)
        else
            parser.produce.from_maybe
        end
    end

    class UnexpectedCharException < Exception
        def initialize(@line_number, @column_number)
            super "Unexpected char at #{@line_number}:#{@column_number}"
        end
    end
end

