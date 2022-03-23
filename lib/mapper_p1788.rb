require_relative 'expr_compiler'

class Mapper_P1788
    @@forward_mapper = {}
    @@backward_mapper = {}
    def self.forward_mapper()
        return @@forward_mapper
    end
    def self.backward_mapper()
        return @@backward_mapper
    end
end