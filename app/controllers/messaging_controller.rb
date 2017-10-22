require 'messaging/script'
require 'messaging/exchange'

class MessagingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    script = Messaging::Script.from_file script_path(:start)
    exchange = Messaging::Exchange.new script: script
    exchange.user_input to: reply[:to], input: reply[:input] if reply
    exchange.process_commands
    exchange.determine_response

    render json: exchange.as_json
  end

  private

  def reply
    params[:reply]
  end

  def script_path(name)
    Rails.root.join('app', 'scripts', "#{name}.json")
  end
end
