
class CardRss
  attr_accessor :title, :item_limit
  attr_reader :items

  def initialize(feed)
    @title = feed.title
    @feed = feed
    @item_limit = 5
  end

  def items
    @feed.items.slice(0,@item_limit)
  end
  
end
