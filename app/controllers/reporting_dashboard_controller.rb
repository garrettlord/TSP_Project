class ReportingDashboardController < ApplicationController

TWILIO_NUMBER = "+19062144698"
  # ACCOUNT_SID = 'ACe6309fe95fd294f06795604a051096c3'
ACCOUNT_SID = 'ACd596ace63991a2ee1c1d04d511bb929d'
  # AUTH_TOKEN = '8467ec204a825f52e0bb7c908915d0cf'
AUTH_TOKEN = 'fd6608ce6be77e3f0e4a839e60021353'

  

  def build()
    @inboundCount = []
    @allTextsCount = []
    
    client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

    #"just inbound texts"
    client.account.usage.records.daily.list({
       :category => "sms-inbound",
       :start_date => "2013-04-02",
       :end_date => "2013-04-06"
      }).each do |record|
          @inboundCount << record.count
    end

    #"inbound and outbound texts"
    client.account.usage.records.daily.list({
       :category => "sms",
       :start_date => "2013-04-02",
       :end_date => "2013-04-06"
      }).each do |record|
      @allTextsCount << record.count
    end

  end 

end