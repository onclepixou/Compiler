# compiler
require_relative 'expr_compiler'

class UnaryOp < Expr
    attr_reader :c
    attr_accessor :var
    def initialize(c)
        super()
        @c = make_expr(c)
        @var=@var= IntermediateVariable.new(0)
    end
    def children()
        [c]
    end
    def set_var(nb)
        @var = IntermediateVariable.new(nb)
    end
    def to_s_header
        "#{super()} #{"VAR".to_s.light_red.bold} : #{var.id.to_s.light_yellow.bold}"
    end
    def to_s(prefix = '', last = true, first = true)
        str = prefix + (first ? '' : (last ? '└─ ' : '├─ '))
        str += to_s_header + "\n"
        prefix = prefix + (first ? '' :(last ? '   ' : '│  '))
        str += c.to_s(prefix, true, false)
        str
    end
end

####################### Unary Op

class Cos < UnaryOp
    def initialize(c)
        super
    end
end
Mapper_P1788.forward_mapper[Cos] = "cos"
# reverse ops of a = cos(b)
Mapper_P1788.backward_mapper[Cos] = [["cos_rev", "b", ["a", "b"]]]

class Sin < UnaryOp
    def initialize(c)
        super
    end
end
Mapper_P1788.forward_mapper[Sin] = "sin"
# reverse ops of a = sin(b)
Mapper_P1788.backward_mapper[Sin] = [["sin_rev", "b", ["a", "b"]]]

class Sqr < UnaryOp
	def initialize(c)
		super
	end
end
Mapper_P1788.forward_mapper[Sqr] = "sqr"
# reverse ops of a = sqr(b)
Mapper_P1788.backward_mapper[Sqr] = [["sqr_rev", "b", ["a", "b"]]]

class Sqrt < UnaryOp
	def initialize(c)
		super
	end
end
Mapper_P1788.forward_mapper[Sqrt] = "sqrt"
# reverse ops of a = sqrt(b)
Mapper_P1788.backward_mapper[Sqrt] = [["sqrt_rev", "b", ["a", "b"]]]

class Exp < UnaryOp
	def initialize(c)
		super
	end
end
Mapper_P1788.forward_mapper[Exp] = "exp"
# reverse ops of a = exp(b)
Mapper_P1788.backward_mapper[Exp] = [["exp_rev", "b", ["a", "b"]]]

#######################

####################### Unary Op func

def cos(e)
	Cos.new(e)
end

def sin(e)
	Sin.new(e)
end

def sqr(e)
	Sqr.new(e)
end

def sqrt(e)
	Sqrt.new(e)
end

def exp(e)
	Exp.new(e)
end

#######################