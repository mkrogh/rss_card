require "rss"
require "open-uri"
require "extractors/feed_entry"

class FeedFetcher

  def self.update(feed)
    rss = RSS::Parser.parse(feed.source)  if feed.source

    unless rss.nil?
      case rss.feed_type
      when "atom"
        update_atom(rss, feed) 
      when "rss"
        update_rss(rss, feed)
      end
    end
  end

  private
  def self.update_atom(rss, feed)
      feed.title = rss.title.content
      rss.entries.each do |entry|
        feed.items << Extractors::AtomFeedEntry.extract(entry)
      end
  end

  def self.update_rss(rss, feed)
      feed.title = rss.channel.title
      rss.items.each do |item|
        feed.items << Extractors::RSSFeedEntry.extract(item)
      end
  end
end
