module Kernel
  def pp(obj)
    obj.pretty_print
  end
end

class Object
  def pretty_print(depth=0)
    puts inspect.indent(depth * 2)
    instance_variables.map do |iv|
      v = instance_variable_get(iv)
      puts v.inspect.indent((depth+1) * 2)
      v.pretty_print(depth + 1)
    end
  end
end

class Array
  def pretty_print(depth=0)
    puts "[".indent(depth * 2)
    map do |obj|
      obj.pretty_print(depth + 1)
    end
    puts "]".indent(depth * 2)
  end
end

class Hash
  def pretty_print(depth=0)
    puts "{".indent(depth * 2)
    each do |key, value|
      key.pretty_print(depth+1)
      value.pretty_print(depth+2)
    end
    puts "}".indent(depth * 2)
  end
end

module Moon
  module DataModel
    class Metal
      def pretty_print(depth=0)
        puts "{{#{self.class.inspect}".indent(depth * 2)
        self.class.all_fields.each do |key, field|
          key.pretty_print(depth+1)
          self[key].pretty_print(depth+2)
        end
        puts "}}".indent(depth * 2)
      end
    end
  end
end
