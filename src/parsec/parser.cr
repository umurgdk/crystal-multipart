require "./maybe"

abstract class Parsec::Parser(T)
    getter error_message
    getter cargo

    def initialize
        @is_satisfied  = false
        @is_failed     = false
        @cargo         = ""

        @error_message = ""
    end

    def satisfied?
        @is_satisfied
    end

    def failed?
        @is_failed
    end

    protected def reset
        @is_satisfied = false
        @is_failed    = false
        @cargo        = ""
    end

    protected def success
        @is_satisfied = true
    end

    protected def fail
        @is_failed = true
    end

    abstract def produce : Maybe(T)
    abstract def step(char : Char)
end
