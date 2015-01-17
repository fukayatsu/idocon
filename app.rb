require 'coffee-script'
require 'sinatra'
require 'slim'
require 'idobata_hook'

set :idobata, IdobataHook::Client.new(ENV["IDOBATA_HOOK_URL"])

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  "#{password}" == ENV["PASSWORD"]
end

get '/' do
  slim :index
end

post '/remote' do
  username = Rack::Auth::Basic::Request.new(request.env).credentials[0]
  settings.idobata.send "#{username}:"
  settings.idobata.send params['command']
  'ok'
end

get '/app.js' do
  coffee :app
end
