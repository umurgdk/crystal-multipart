require "../src/parsec"
require "../src/parsec/any"
require "../src/parsec/many"
require "../src/parsec/plus"
require "../src/parsec/string"
require "../src/parsec/or"

any_char = Parsec::Any.new("Empty string")
read_through = Parsec::Many(Char).new(any_char)

hello = Parsec::StringParser.new "Hello"
world = Parsec::StringParser.new "World"

part1 = Parsec::Plus.new hello, any_char
part2 = Parsec::Plus.new part1, world

ruby = Parsec::StringParser.new "ruby"
crystal = Parsec::StringParser.new "crystal"

ruby_or_crystal = Parsec::Or.new ruby, crystal

parsed = Parsec.run_parser(part2, "Hello World!")
puts "Parsed char: #{parsed.inspect}"

puts "Parsing 'python'"
parsed = Parsec.run_parser(ruby_or_crystal, "python")
puts "Parsed prog lang: #{parsed.inspect}"
