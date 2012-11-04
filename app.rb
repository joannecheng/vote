require 'twilio-ruby'
require 'sinatra'
require 'civic_info'

account_sid = ENV['TWILIO_ACCT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']

get '/sms' do
  twiml = Twilio::TwiML::Response.new do |r|
    r.Sms "testing testing 123"
  end
  twiml.text
end

