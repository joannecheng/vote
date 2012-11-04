require 'twilio-ruby'
require 'sinatra'
require 'civic_info'

account_sid = ENV['TWILIO_ACCT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']

post '/sms' do
  @ci = CivicInfo.new()
  voter = @ci.voter_info(4000, params[:Body])
  twiml = Twilio::TwiML::Response.new do |r|
    if !voter[:pollingLocations].nil?
      location = voter[:pollingLocations].first[:address]
      r.Sms "closest polling loc: #{location[:locationName]} #{location[:line1]} #{location[:city]} #{location[:state]}"
    else
      r.Sms "No polling locations found."
    end
  end
  twiml.text
end

