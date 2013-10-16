require "json"

class CardRss
  attr_accessor :item_limit
  attr_reader :items

  def initialize(feed)
    @feed = feed
    @item_limit = 5
  end

  def title
    @feed.title
  end

  def items
    @feed.items.slice(0,@item_limit)
  end

  def update
    FeedFetcher.update(@feed)
  end

  def to_json(*a)
    {
      card: {
        title: title,
        items: items 
      }
    }.to_json(*a)
    
  end
  
end
