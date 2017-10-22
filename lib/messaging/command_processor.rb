module Messaging
  class CommandProcessor
    def initialize(command_namespace)
      @namespace = command_namespace
    end

    def process_command_named(name, input)
      command_for_name(name).call(input)
    end

    def command_for_name(name)
      command_class_name = "#{@namespace}::#{name.camelize}"
      command_class_name.constantize.new
    end
  end
end
