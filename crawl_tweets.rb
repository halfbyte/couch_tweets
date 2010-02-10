QUERY = "couchdb"
require 'rubygems'
require 'couchrest'
require 'twitter'

class Tweet

  PROPERTY_MAP = {
    :created_at => :published_at,
    :from_user => :from_user,
    :profile_image_url => :profile_image_url,
    :source => :source,
    :text => :text,
    :to_user => :to_user,
    :id => :tweet_id
  }

  SERVER = CouchRest::Server.new
  DB = CouchRest::Database.new(SERVER, "tweets")


  def initialize(opts)
    @hash = opts
  end

  def to_hash
    @hash
  end


  def tweet_id
    @hash[:tweet_id]
  end
  def self.from(mash)
    hash = {}
    mash.each do |k,v|

      if PROPERTY_MAP.key?(k.to_sym)
        hash[PROPERTY_MAP[k.to_sym]] = v
        if PROPERTY_MAP[k.to_sym] == :"_id"
          hash[PROPERTY_MAP[k.to_sym]] = v.to_s
        end
      end
    end
    Tweet.new(hash)
  end

  def self.update_all
    Twitter::Search.new(QUERY).per_page(100).each do |r|
      tweet = Tweet.from(r)
      view = DB.view("tweets/tweet_ids", "key" => tweet.tweet_id)
      if view['rows'].length == 0
        DB.save_doc(tweet.to_hash)
      else
        puts "identical tweet, not saving"
      end
    end
  end
end

Tweet.update_all
