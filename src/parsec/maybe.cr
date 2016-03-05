class Maybe(T)
    class Just(T)
        getter content
        def initialize(@content : T)
        end

        def from_maybe
            @content
        end
    end

    class Nothing(T)
        def from_maybe
            nil
        end
    end

    def self.just(content : T)
        Just(T).new(content)
    end

    def self.nothing
        Nothing(T).new
    end
end
