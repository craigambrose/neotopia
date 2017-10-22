require 'messaging/script'
require 'messaging/exchange'
require 'messaging/command_processor'

class MessagingController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    script = Messaging::Script.from_file script_path(:start)
    context = Context.new(encoded_token: bearer_token)
    command_processor = Messaging::CommandProcessor.new('Users::Commands')

    exchange = Messaging::Exchange.new script: script, context: context
    exchange.user_input to: reply[:to], input: reply[:input] if reply
    exchange.process_commands command_processor
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

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization'] # <= env
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end
