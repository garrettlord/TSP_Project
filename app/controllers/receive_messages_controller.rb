class ReceiveMessagesController < ApplicationController
  include ParseHelper
  include TwilioHelper

  # POST /process_sms
  def process_sms
    # get array of message words
    body = params[:Body]
    words = body.split(" ")

    # first word is group name, message is the rest
    @group = words[0]
    @message = words[1..-1].join(" ")

    # find the user's name from their phone number
    fromNumRaw = params[:From].split("")
    fromNum = "#{fromNumRaw[2..4]}-#{fromNumRaw[5..7]}-#{fromNumRaw[8..1]}"
    userID = User.find_by_phone_number(fromNum)
    unless(userID.nil?)
      @userName = User.find_by_phone_number(fromNum).name
    else
      @userName = "UNKNOWN"
    end

    # send the message
    @message = "#{@group}: #{@userName} - #{@message}"
    send_text(@group, @message)

    render '/list_texts/list_texts.xml.erb', :content_type => 'text/xml'
  end
end
