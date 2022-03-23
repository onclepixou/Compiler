#!/usr/bin/env ruby

# external gems
require 'colorize'

# compiler
require_relative '../lib/expr_compiler'

exp1 = Expr.build do |x,y|
    sqr(x - 1) + sqr(y - 2)
end

exp2 = Expr.build do |x,y|
    (sin(sqr(x)+sqr(y)))/(exp(x)+sqr(y))
end

exp3 = Expr.build do |x,y|
    ((y - 5) * cos(4 * sqrt(sqr(x - 4) + sqr(y)))) - (x * sin(2*sqrt(sqr(x) + sqr(y))))  # > 0
end

exp4 = Expr.build do |x,y|
    (exp(x * y) - sin(x - y))
end


def all_steps(exp)
    puts "##################################"
    puts "Base expression".light_cyan.bold
    puts exp

    Marker.reset_var
    exp.bfs_f(:mark)
    puts "\nIntermediate variables marking".light_cyan.bold
    puts exp

    ForwardBuilder.clear_ops
    exp.bfs_f(:forward) 
    ops_forward = ForwardBuilder.ops
    puts "\nForward operations".light_cyan.bold
    puts ops_forward

    BackwardBuilder.clear_ops
    exp.bfs_b(:backward) 
    ops_backward = BackwardBuilder.ops
    puts "\nBackward operations".light_cyan.bold
    puts ops_backward
    puts "##################################"
    puts "\n"
end



all_steps(exp1)
all_steps(exp2)
all_steps(exp3)
all_steps(exp4)