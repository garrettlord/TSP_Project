require 'rubygems'
require 'httparty'
require 'ywx'
require 'pp'
appid = 'LCQO6F3V34FE6FIki6XMq3Pg8pd46EgovEi7AYFFTcA4cStxIre2CB8tpE7Xy.PjfL_OUgrk_MJ64JG.bLDXkx_XazODfr4-'

@client = YahooWeather::Client.new(appid)

response = @client.lookup_zip(49931)
pp "Info"
pp response.title
pp response.condition.temp
pp response.condition.text
pp "Conditions"
pp response.condition.temp
pp response.units.temperature
pp response.condition.text
pp "Forecast"
pp "#{response.forecasts[0].day} - #{response.forecasts[0].text}.  High: #{response.forecasts[0].high} Low: #{response.forecasts[0].low}"
pp "#{response.forecasts[1].day} - #{response.forecasts[1].text}.  High: #{response.forecasts[1].high} Low: #{response.forecasts[1].low}"