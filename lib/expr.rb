# external gems
require 'colorize'

# compiler
require_relative 'expr_compiler'

class Expr
    attr_reader :terminal
    def initialize()
        @terminal=false
    end
    def +(r)
        Add.new(self, r)
    end
    def -(r)
        Sub.new(self, r)
    end
    def *(r)
        Mul.new(self, r)
    end
    def /(r)
        Div.new(self, r)
    end
    def self.build(&b)
        v = b.parameters.collect{|a| Variable.new(a[1])}
        yield(*v)
    end
    def coerce(obj)
        [Constant.new(obj), self]
    end
    def make_expr(obj)
        if obj.is_a?(Expr) then
            obj
        else
            Constant.new(obj)
        end
    end
    def children()
        raise "you must derive from the #{Expr} class and implement the 'children' method"
    end
    def op?()
        return ( (self.is_a? UnaryOp) || (self.is_a? BinaryOp) )
    end
    def bfs_f(func)
        children.each do |child|
            child.bfs_f(func)
        end
        method(func).call(self)
    end
    def bfs_b(func)
        method(func).call(self)
        children.each do |child|
            child.bfs_b(func)
        end
    end
    def to_s_header
        "#{self.class.name.sub(/^.+::/, '').light_blue.bold}"
    end
    def to_s(prefix = '', last = true, first = true)
        str = prefix + (first ? '' : (last ? '└─ ' : '├─ '))
        str += to_s_header + "\n"
        str
    end
end

class IntermediateVariable < Expr
    attr_reader :name
    attr_reader :id
    def initialize(nb)
        super()
        @name = "_v" + nb.to_s
        @id = nb
        @terminal = true
    end
    def children()
        []
    end
    def compute_str()
        @name.to_s
    end
    def to_s_header
        "#{super()} ID : #{@name.to_s.light_green.bold}"
    end
end

class Variable < Expr
    attr_reader :name
    def initialize(n)
        super()
        @name = n
        @terminal=true
    end
    def children()
        []
    end
    def compute_str()
        @name.to_s
    end
    def to_s_header
        "#{super()} ID : #{@name.to_s.light_green.bold}"
    end
end

class Constant < Expr
    attr_reader :value
    def initialize(v)
        super()
        @value = v
        @terminal=true
    end
    def children()
        []
    end
    def compute_str()
        @value.to_s
    end
    def to_s_header
        "#{super()} VALUE : #{@value.to_s.light_green.bold}"
    end
end