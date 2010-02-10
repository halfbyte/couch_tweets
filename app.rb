require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'haml'

SERVER = CouchRest::Server.new
DB = CouchRest::Database.new(SERVER, "tweets")


get '/' do
  @tweeters = DB.view("tweets/tweeters", :group => true)['rows'].sort_by{|r| r['value']}.reverse
  haml :index
end

get '/:tweeter' do
  @tweets = DB.view("tweets/tweets", :key => params[:tweeter])
  haml :tweeter
end