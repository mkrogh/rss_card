require "json"
#
# A simple feed meant to hold the content of an RSS feed.
# 
class Feed
  attr_accessor :source, :title, :items, :updated
  
  # Creates a new feed.
  # @param source [String] the source url for the feed   
  def initialize(source)
    @source = source
    @items = []
  end


  def to_json(*a)
    {feed: 
      {
        title: @title,
        source: @source,
        updated: @updated,
        items: @items,
      }
    }.to_json(*a)
  end

  def self.from_json(json)
    if json.is_a?(Hash)
       obj = json["feed"]
    else
      obj = JSON.parse(json)['feed']
    end
    feed = new(obj['source'])
    feed.title = obj['title']
    feed.updated = Time.parse(obj['updated'])
    obj['items'].each do |item|
      feed.items << Item.from_json(item)
    end
    feed
  end
end
