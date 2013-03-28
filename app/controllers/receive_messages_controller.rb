require File.join(Rails.root, "lib/parse_helper.rb")

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
    fromNum = "#{fromNumRaw[2..4].join}-#{fromNumRaw[5..7].join}-#{fromNumRaw[8..1].join}"
    user= User.find_by_phone_number(fromNum)
    unless(user.nil?)
      @userName = user.name
    else
      @userName = "#{fromNum}"
    end

    # send the message
    @message = "#{@group}: #{@userName} - #{@message}"
    send_text(@group, @message)

    render '/list_texts/list_texts.xml.erb', :content_type => 'text/xml'
  end
end
