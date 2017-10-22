module Users
  module Commands
    class SetName
      def call(input, context)
        context.user_name = input['text']
      end
    end
  end
end
