require 'twilio-ruby'
require 'sinatra'
require 'civic_info'

account_sid = ENV['TWILIO_ACCT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']
@ci = CivicInfo.new()

get '/' do
  "hello world"
end

post '/sms' do
  twiml = Twilio::TwiML::Response.new do |r|
    r.Sms "closest polling loc: #{@ci.voter_info(4000, params[:Body])[:polingLocations][:address][0].to_s}" || "No polling locations found."
  end
  twiml.text
end

