require 'twilio-ruby'
require 'sinatra'
require 'civic_info'

account_sid = ENV['TWILIO_ACCT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']

get '/' do
  "hello world"
end

post '/sms' do
  @ci = CivicInfo.new()
  voter = @ci.voter_info(4000, params[:Body])
  twiml = Twilio::TwiML::Response.new do |r|
    if !voter[:pollingLocations].nil?
      r.Sms "closest polling loc: #{voter[:pollingLocations].first[:address][:line1]}"
    else
      r.Sms "No polling locations found."
    end
  end
  twiml.text
end

