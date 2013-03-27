class TextMessagesController < ApplicationController
  include TwilioHelper

  # GET /text_messages/new
  def new
    @text_message = TextMessage.new
  end

  # POST /text_messages
  def create
    successes, errors = send_text(params[:text_message][:group_name], params[:text_message][:message])
    unless errors.nil?
      flash[:errors] = errors
      flash[:successes] = successes
      if (flash[:errors].any?)
        render :action => :status, :status => :bad_request
      else
        render :action => :status
      end
    else
      errors ||= []
      successes ||= []
      render :action => :status, :status => :bad_request
    end
  end

end
