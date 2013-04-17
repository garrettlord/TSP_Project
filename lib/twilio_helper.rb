module TwilioHelper

  # twilio account information
  TWILIO_NUMBER = "+19062144698"
  ACCOUNT_SID = 'ACd596ace63991a2ee1c1d04d511bb929d'
  AUTH_TOKEN = 'fd6608ce6be77e3f0e4a839e60021353'

  def send_group_text(user, group, message)
    logger.info "debug::send_group_text called"
    group_message = GroupMessage.create(group_id: group.id, user_id: user.id, message: message)
    text_message = TextMessage.new(group_name: group.name, message: message)
    logger.info "debug::group message and text message created"

    if text_message.valid?
      logger.info "debug::text message is valid"
      numbers = text_message.numbers_array
      logger.info "debug::got numbers array"
      
      numbers.each do |number|
        logger.info "debug::calling send_text"
        send_text(number, text_message.message)
      end # num each
      logger.info "debug::finished calling send_text"
    else
      logger.info "debug::TEXT MESSAGE NOT VALID"
    end # if
  end # def

  def send_poll(group, message)
    text_message = TextMessage.new(group_name: group.name, message: message)

    if text_message.valid?
      numbers = text_message.numbers_array
      
      numbers.each do |number|
        logger.debug "debug::sending poll"
        send_text(number, text_message.message)
      end # num each
    else
      logger.debug "debug::text message not valid"
    end # if
  end # def

  def send_text(number, message)
    unless message.empty?
      account = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN).account

      texts = message.scan(/.{1,120}/m)

      texts.each do |text|
        logger.info "info::sending message: #{text} to: #{number}"
        begin
          account.sms.messages.create(
              :from => TWILIO_NUMBER,
              :to => "+1#{number}",
              :body => text
          )
        rescue Exception => e
          logger.info "error::error sending message: #{e.to_s}"
        end # begin
      end
    end
  end
end # module
