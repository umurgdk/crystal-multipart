#macro choice(*parsers)
    #%current_column = @column_number
    #begin
    #{% for name, index in parsers %}
        #{{name}}
        #{% if index < parsers.size - 1 %}
    #rescue
        #{% else %}
    #end
        #{% end %}
    #{% end %}
#end

begin
    raise Exception.new("e1")
rescue
    raise Exception.new("e2")
rescue
    puts "hehe"
end
