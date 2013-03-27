class ReceiveMessagesController < ApplicationController

  # POST /process_sms
  def process_sms
    @city = params[:FromCity].capitalize
    @state = params[:FromState]
    render '/list_texts/list_texts.xml.erb', :content_type => 'text/xml'
  end

end
