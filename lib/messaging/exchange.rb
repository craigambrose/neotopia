require_relative 'script'
require_relative 'interpolator'

module Messaging
  class Exchange
    def initialize(script:, context: nil)
      @script = script
      @context = context
      @interpolator = Interpolator.new(context)
      @previous_message = nil
      @input = nil
      @response_message = nil
      @command_result = nil
    end

    def user_input(to:, input:)
      @previous_message = script.find_message(to)
      @input = input
    end

    def determine_response
      target = script.transition_for input: input, command_result: command_result, previous: previous_message
      if target
        @response_message = target.get_message script
        raise "no message found to transition to with #{target.inspect}" unless @response_message

        target.apply_overrides @response_message
      else
        raise 'no transition found'
      end
      @response_message
    end

    def process_commands(command_processor)
      return unless previous_message

      if previous_message.command_name
        @command_result = command_processor.process_command_named previous_message.command_name, input, context
      end
    end

    def as_json
      {
        message: response_message.as_json(interpolator),
        data: (context ? context.as_json : {})
      }
    end

    private

    attr_reader :script, :previous_message, :response_message, :input,
                :context, :interpolator, :command_result
  end
end
