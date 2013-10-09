require "rss_card/models"
module  Extractors

  class AtomFeedEntry
    def self.extract(entry)
      item = Item.new
      item.title = entry.title.content
      item.updated = entry.updated.content
      item.content = entry.content.content
      item.url = entry.link.href

      item
    end 
  end

  class RSSFeedEntry
    def self.extract(entry)
      item = Item.new
      item.title = entry.title
      item.updated = entry.pubDate if entry.respond_to? "pubDate"
      item.content = entry.description
      item.url = entry.link

      item
    end 
  end
end
