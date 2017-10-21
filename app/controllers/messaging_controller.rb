require 'messaging/script'
require 'messaging/exchange'

class MessagingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    script = Messaging::Script.from_file script_path(:start)
    exchange = Messaging::Exchange.new script: script
    message = exchange.determine_response
    render json: {message: message.as_json}
  end

  private

  def script_path(name)
    Rails.root.join('app', 'scripts', "#{name}.json")
  end
end
