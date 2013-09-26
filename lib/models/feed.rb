#
# A simple feed meant to hold the content of an RSS feed.
# 
class Feed
  attr_accessor :source, :title, :items
  
  # Creates a new feed.
  # @param source [String] the source url for the feed   
  def initialize(source)
    @source = source
    @items = []
  end
end
