class Token
  ALGORITHM = 'HS256'.freeze

  class << self
    def decode(encoded_token)
      payload, _headers = JWT.decode encoded_token, token_secret, true, algorithm: ALGORITHM
      Rails.logger.debug "Decoding token: #{payload.inspect}"
      new payload
    rescue JWT::DecodeError => e
      raise "#{e} with #{encoded_token.inspect}"
    end

    def token_secret
      Rails.application.secrets.secret_key_base
    end
  end

  def initialize(payload = {})
    @payload = payload
  end

  def encoded
    Rails.logger.debug "Encoding token: #{payload.inspect}"
    JWT.encode payload, self.class.token_secret, ALGORITHM
  end

  def name=(value)
    payload['name'] = value
  end

  def name
    payload['name']
  end

  def sub
    payload['sub']
  end

  def sub=(value)
    payload['sub'] = value
  end

  attr_reader :payload
end
