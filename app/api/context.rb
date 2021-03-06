class Context
  extend Memoist

  def initialize(encoded_token: nil)
    @token = encoded_token ? Token.decode(encoded_token) : Token.new(sub: SecureRandom.uuid)
  end

  def as_json
    {
      token: token.encoded,
      user: user_as_json
    }.compact
  end

  def user_name=(value)
    token.name = value
  end

  def user_uuid=(value)
    token.sub = value
  end

  def user_name
    token.name
  end

  def user_uuid
    token.sub
  end

  def signed_up?
    !user.nil?
  end

  def read_value(key)
    case key
    when 'current_user.name'
      user_name
    else
      "*#{key}*"
    end
  end

  private

  attr_reader :token

  def user_as_json
    if user_name
      {
        id: user_uuid,
        name: user_name,
        signed_up: signed_up?
      }
    end
  end

  def token_secret
    Rails.application.secrets.secret_key_base
  end

  def user
    user_uuid && User.find_by_uuid(user_uuid)
  end

  memoize :user
end
