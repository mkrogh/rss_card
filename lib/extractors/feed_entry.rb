require "models/item"
module  Extractors

  class AtomFeedEntry
    def self.extract(entry)
      item = Item.new
      item.title = entry.title.content
      item.updated = entry.updated.content
      item.content = entry.content.content

      item
    end 
  end

  class RSSFeedEntry
    def self.extract(entry)
      item = Item.new
      item.title = entry.title
      item.updated = entry.pubDate if entry.respond_to? "pubDate"
      item.content = entry.description

      item
    end 
  end
end
