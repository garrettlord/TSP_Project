module ApplicationHelper
  TWILIO_NUMBER = "+19062144698"
  # ACCOUNT_SID = 'ACe6309fe95fd294f06795604a051096c3'
  ACCOUNT_SID = 'ACd596ace63991a2ee1c1d04d511bb929d'
  # AUTH_TOKEN = '8467ec204a825f52e0bb7c908915d0cf'
  AUTH_TOKEN = 'fd6608ce6be77e3f0e4a839e60021353'

  def send_text(group, message)
    @text_message = TextMessage.new(group_name: group, message: message)
    
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
  end

  # returns the full title on a per-page basis
  def full_title(page_title)
    base_title = "TSP Project Spring 2013"
    if page_title.empty?
    base_title
    else
      "#{base_title} | #{page_title}"
    end
  end 
end

