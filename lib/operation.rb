# external gems
require 'colorize'

require_relative 'expr_compiler'

class Operation
    attr_reader :output
    attr_reader :op_str
    attr_reader :args
    def initialize(output, op, args)
        @output = output
        @op_str = op
        @args = args
    end
    def to_s
        "#{output.compute_str.light_green.bold} = #{op_str.light_blue.bold}(#{args.map!(&:compute_str).join(",").light_red.bold})"
    end
end