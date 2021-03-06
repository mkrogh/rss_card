require "rss"
require "open-uri"
require "rss_card/extractors"

class FeedFetcher

  def self.update(feed, feed_data=nil)
    if feed_data
      rss = RSS::Parser.parse(feed_data)
    elsif feed.source
      rss = RSS::Parser.parse(feed.source)
    end

    unless rss.nil?
      case rss.feed_type
      when "atom"
        update_atom(rss, feed) 
      when "rss"
        update_rss(rss, feed)
      end
    end
    feed.updated = Time.now
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
