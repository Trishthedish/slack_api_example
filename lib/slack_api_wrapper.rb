require 'httparty'
require 'awesome_print'

class Slack_Api_Wrapper
  # you need to use a token
  BASE_URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]
  # The BASE_URL is the beginning of every request, and the TOKEN will be the Slack API token we made available through the .env file earlier.

  def self.list_channels()
    url = BASE_URL + "channels.list?token=#{TOKEN}"

    response = HTTParty.get(url)

    my_channels = []

    response["channels"].each do |channel|
      id = channel["id"]
      name = channel["name"]
      my_channels << Slack_Channel.new(name, id)
    end
    my_channels
  end

    def sendmsg(channel, message)
    end


end
