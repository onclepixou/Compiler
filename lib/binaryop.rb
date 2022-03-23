# compiler
require_relative 'expr_compiler'

class BinaryOp < Expr
    attr_reader :left, :right
    attr_accessor :var
    def initialize(l, r)
        super()
        @left = make_expr(l)
        @right = make_expr(r)
        @var= IntermediateVariable.new(0)
    end
    def children()
        [left, right]
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
        str += @left.to_s(prefix, false, false)
        str += @right.to_s(prefix, true, false)
        str
    end
end

####################### Binary Op

class Add < BinaryOp
    def initialize(l, r)
        super
    end
end
Mapper_P1788.forward_mapper[Add] = "add"
# reverse ops of a = b + c
Mapper_P1788.backward_mapper[Add] = [["add_rev", "c", ["b", "a", "c"]],  ["add_rev", "b", ["c", "a", "b"]]]


class Sub < BinaryOp
	def initialize(l, r)
		super
	end
end
Mapper_P1788.forward_mapper[Sub] = "sub"
# reverse ops of a = b - c
Mapper_P1788.backward_mapper[Sub] = [["add_rev", "c", ["a", "b", "c"]],  ["sub_rev1", "b", ["c", "a", "b"]]]

class Mul < BinaryOp
	def initialize(l, r)
		super
	end
end
Mapper_P1788.forward_mapper[Mul] = "mul"
# reverse ops of a = b * c
Mapper_P1788.backward_mapper[Mul] = [["mul_rev", "b", ["c", "a", "b"]],  ["mul_rev", "c", ["b", "a", "c"]]]

class Div < BinaryOp
	def initialize(l, r)
		super
	end
end
Mapper_P1788.forward_mapper[Div] = "div"
# reverse ops of a = b * c
Mapper_P1788.backward_mapper[Div] = [["div_rev", "b", ["c", "a", "b"]],  ["mul_rev", "c", ["b", "a", "c"]]]

#######################

####################### binary Op func


#######################