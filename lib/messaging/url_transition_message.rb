module Messaging
  class UrlTransitionMessage
    def initialize(url)
      @url = url
    end

    attr_reader :url

    def as_json(_interpolator = nil)
      {
        id: url,
        url: url
      }
    end
  end
end
