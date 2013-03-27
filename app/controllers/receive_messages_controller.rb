class ReceiveMessagesController < ApplicationController

  # POST /process_sms
  def process_sms
    @city = params[:FromCity].capitalize
    @state = params[:FromState]
    body = params[:Body]
    words = body.split(" ")
    @group = words[0]
    @message = words[1..-1].join(" ")
    fromNum = params[:From]
    userID = User.find_by_phone_number(fromNum)
    unless(userID.nil?)
      @userName = User.find_by_phone_number(fromNum).name
    else
      @userName = "UNKNOWN"
    end

    send_text(@group, @message)

    render '/list_texts/list_texts.xml.erb', :content_type => 'text/xml'
  end
end
