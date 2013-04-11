module TwilioHelper

  # twilio account information
  TWILIO_NUMBER = "+19062144698"
  ACCOUNT_SID = 'ACd596ace63991a2ee1c1d04d511bb929d'
  AUTH_TOKEN = 'fd6608ce6be77e3f0e4a839e60021353'

  def send_group_text(user, group, message)
    group_message = GroupMessage.create(group_id: group.id, user_id: user.id, message: message)
    text_message = TextMessage.new(group_name: group.name, message: message)

    if text_message.valid?
      numbers = text_message.numbers_array
      
      numbers.each do |number|
        send_text(number, text_message.message)
      end # num each
    end # if
  end # def

  def send_text(number, message)
    unless message.empty?
      account = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN).account

      logger.info "sending message: #{message} to: #{number}"
      begin
        account.sms.messages.create(
            :from => TWILIO_NUMBER,
            :to => "+1#{number}",
            :body => message
        )
      rescue Exception => e
        logger.error "error sending message: #{e.to_s}"
      end # begin
    end
  end
end # module
