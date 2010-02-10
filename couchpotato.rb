CouchPotato::Config.database_name = 'name_of_the_db'

class Tweet
  include CouchPotato::Persistance
  property :from_name
  property :text
  property :tweet_id
end

tweet = Tweet.new(
  :from_name => 'halfbyte',
  :text => 'couchdb rocks',
  :tweet_id => 5162352
)

CouchPotato.database.save_document tweet