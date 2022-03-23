require_relative 'expr_compiler'

###########################################
class Traversal
end
###########################################

###########################################
class Marker < Traversal
    @@var = 0
    def self.next_var
        cur=@@var
        @@var+=1
        cur
    end
    def self.mark(expr)
        return unless expr.op?
        expr.set_var(next_var)
    end
    def self.reset_var()
        @@var = 0
    end
end

def mark(arg)
    return Marker.mark(arg)
end
###########################################

###########################################
class ForwardBuilder  < Traversal
    @@ops = []
    def self.clear_ops()
        @@ops = []
    end
    def self.ops()
        return @@ops
    end
    def self.build(expr)
        return unless expr.op?
        intermediate_var = IntermediateVariable.new(expr.var.id)
        args = []
        expr.children.each do |child|
            if child.op?
                args.append(child.var)
            else
                args.append(child)
            end
        end
        if(!Mapper_P1788.forward_mapper.has_key?(expr.class))
            raise "#{expr.class} has no function in forward mapper"
        end
        op_str = Mapper_P1788.forward_mapper[expr.class]
        @@ops.append(Operation.new(intermediate_var, op_str, args))
    end
end

def forward(arg)
    return ForwardBuilder.build(arg)
end
###########################################

###########################################
class BackwardBuilder  < Traversal
    @@ops = []
    def self.clear_ops()
        @@ops = []
    end
    def self.ops()
        return @@ops
    end
    def self.build(expr)
        return unless expr.op?
        a = expr.var
        b = (expr.children[0].op?) ? IntermediateVariable.new(expr.children[0].var.id) : expr.children[0]
        c = nil unless expr.is_a? BinaryOp
        if(expr.is_a? BinaryOp)
            c = (expr.children[1].op?) ? IntermediateVariable.new(expr.children[1].var.id) : expr.children[1]
        end
        operands = {"a" => a, "b" => b, "c" => c}
        if(!Mapper_P1788.backward_mapper.has_key?(expr.class))
            raise "#{expr.class} has no function in backward mapper"
        end
        Mapper_P1788.backward_mapper[expr.class].each do |rule|
            op_str = rule[0]
            out = operands[rule[1]]
            args = []
            rule[2].each {|input|  args.append(operands[input])}
            @@ops.append(Operation.new(out, op_str, args)) unless out.is_a? Constant
        end
    end
end

def backward(arg)
    return BackwardBuilder.build(arg)
end
###########################################