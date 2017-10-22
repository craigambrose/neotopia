class Context
  def initialize(encoded_token: nil)
    @token = encoded_token ? Token.decode(encoded_token) : Token.new(sub: SecureRandom.uuid)
  end

  def as_json
    {
      token: token.encoded
    }
  end

  def user_name=(value)
    token.name = value
  end

  def user_name
    token.name
  end

  private

  attr_reader :token

  def token_secret
    Rails.application.secrets.secret_key_base
  end
end
