require "../src/parsec"
require "../src/parsec/any"
require "../src/parsec/many"
require "../src/parsec/plus"
require "../src/parsec/string"

any_char = Parsec::Any.new("Empty string")
read_through = Parsec::Many(Char).new(any_char)

hello = Parsec::StringParser.new "Hello"
world = Parsec::StringParser.new "World"

part1 = Parsec::Plus.new hello, world
#part2 = Parsec::Plus.new part1, any_char


parsed = Parsec.run_parser(part1, "Hello World!")
puts "Parsed char: #{parsed.inspect}"
