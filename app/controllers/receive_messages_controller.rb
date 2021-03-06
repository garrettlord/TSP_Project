require File.join(Rails.root, "lib/parse_helper.rb")

class ReceiveMessagesController < ApplicationController
  include ParseHelper

  # POST /process_sms
  def process_sms
    # get array of message words
    body = params[:Body]

    # find the user's name from their phone number
    fromNumRaw = params[:From].split("")
    fromNum = "#{fromNumRaw[2..4].join}-#{fromNumRaw[5..7].join}-#{fromNumRaw[8..-1].join}"
    user = User.find_by_phone_number(fromNum)
    if user.nil?
      @error = "Could not find user"
      user = User.new(name: "unknown", phone_number: fromNum)
    end
    
    parse(user, body)

    render '/list_texts/list_texts.xml.erb', :content_type => 'text/xml'
  end
end
