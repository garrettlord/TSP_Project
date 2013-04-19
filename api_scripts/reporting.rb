require 'rubygems'
require 'twilio-ruby' # Download twilio-ruby from twilio.com/docs/libraries
 
# Get your Account Sid and Auth Token from twilio.com/user/account 
TWILIO_NUMBER = "+19062144698"
# ACCOUNT_SID = 'ACe6309fe95fd294f06795604a051096c3'
ACCOUNT_SID = 'ACd596ace63991a2ee1c1d04d511bb929d'
# AUTH_TOKEN = '8467ec204a825f52e0bb7c908915d0cf'
AUTH_TOKEN = 'fd6608ce6be77e3f0e4a839e60021353'

@client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

#A daily count over a date range of all inbound texts

@inbound = []
@allTexts = []

puts "just inbound texts"
@client.account.usage.records.daily.list({
   :category => "sms-inbound",
   :StartDate=>'-30days'
  }).each do |record|
    # puts record.start_date
    # puts record.count
    # if record.count.nil? 
    #   @inbound << 0
    # else
      @inbound << record.count
    # end
end

puts @inbound

puts "---------------------------------------"
#A daily count over a date range of all inbound and outbound text

puts "inbound and outbound texts"
@client.account.usage.records.daily.list({
   :category => "sms",
   # :StartDate=-30days
  }).each do |record|
  # puts record.start_date
  @allTexts << record.count
  # puts record.count
end

puts @allTexts



# puts @client.account.methods.sort
 
 
# @client.account.usage.records.daily.list({
#     :category => "sms",}).each do |record|
#     puts record.sid
# end


# Loop over messages and print out a property for each one
# @account.sms.messages.list.each do |message|
#   puts "\ n"
#     puts message.body
# end


# @client.account.usage.records.last_month.list.each do |record|
#     puts record.sid
# end

# @client.account.usage.records.last_month.list.each do |record|
#     puts record.sid
# end