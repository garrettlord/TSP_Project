class TextMessagesController < ApplicationController

  # twilio account information
  # TWILIO_NUMBER = "+19069346838"
  TWILIO_NUMBER = "+19062144698"
  # ACCOUNT_SID = 'ACe6309fe95fd294f06795604a051096c3'
  ACCOUNT_SID = 'ACd596ace63991a2ee1c1d04d511bb929d'
  # AUTH_TOKEN = '8467ec204a825f52e0bb7c908915d0cf'
  AUTH_TOKEN = 'fd6608ce6be77e3f0e4a839e60021353'

  # GET /text_messages/new
  def new
    @text_message = TextMessage.new
  end

  # POST /text_messages
  def create
    @text_message = TextMessage.new(params[:text_message])

    if @text_message.valid?

      successes = []
      errors = []
      numbers = @text_message.numbers_array
      account = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN).account
      
      numbers.each do |number|
        logger.info "sending message: #{@text_message.message} to: #{number}"

        begin
          account.sms.messages.create(
              :from => TWILIO_NUMBER,
              :to => "+1#{number}",
              :body => @text_message.message
          )
          successes << "#{number}"
        rescue Exception => e
          logger.error "error sending message: #{e.to_s}"
          errors << e.to_s
        end
      end

      flash.now[:errors] = errors
      flash.now[:successes] = successes
      if (flash[:errors].any?)
        render :action => :status, :status => :bad_request
      else
        render :action => :status
      end

    else
      render :action => :new, :status => :bad_request
    end
  end

end