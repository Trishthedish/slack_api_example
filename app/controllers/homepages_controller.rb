#require "slack_api_wrapper"
#require "channel"



class HomepagesController < ApplicationController
  def index
    # an array of channels
    @data = Slack_Api_Wrapper.list_channels
  end

  def create
    response = Slack_Api_Wrapper.send_message(params[:channel], params[:message],params[:icon_url])

     if response["ok"]
       flash[:notice] = "Mischief managed: your msg got sent ✅ to #{params[:channel]}!"

     else
       flash[:notice] = "Message failed to be sent to #{params[:channel]}"

     end
      redirect_to root_path
  end

#>> params
# => {"utf8"=>"✓", "authenticity_token"=>"SEBhcjZ68M0QhqNizEtALXGkwJKawxhYnW54I9Ogz+NCgM3Y6OjXpZGvfuMlQMADqJvMONIRft9Aqw0FTeCQeg==", "messag

  def new
    @channel = params[:name]
    @channel_id = params[:id]


  end
end
