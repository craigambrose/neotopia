require_relative 'transitions/to_message'
require_relative 'transitions/to_url'

module Messaging
  module Transitions
    def self.from_data(data)
      if data.is_a?(String)
        from_string(data)
      elsif data.is_a?(Hash)
        from_hash(data)
      else
        raise ArgumentError, "Unknown transition data: #{data.inspect}"
      end
    end

    def self.from_string(string)
      ToMessage.new string
    end

    def self.from_hash(hash)
      if hash['url']
        ToUrl.new hash['url']
      else
        raise ArgumentEror, "hash must have a \"to\" field: #{hash.inspect}" if hash['to'].blank?
        ToMessage.new hash['to'], hash['overrides']
      end
    end
  end
end
