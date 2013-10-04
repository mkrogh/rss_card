require "spec_helper"
require "rss"
require "extractors/feed_entry"

describe  Extractors::AtomFeedEntry do

  context "when extracting an atom entry" do
    before(:all) do
      @entry = load_atom_entry
    end
    
    subject {Extractors::AtomFeedEntry.extract(@entry)}

    its(:title) { should eq "Coffee"}
    its(:updated){should eq Time.new(2013,10,04)}
    its(:content){should include("conical burr grinder")}
  end

  context "when extracting a rss 2.0 entry" do
    before(:all) do
      @entry = load_rss_entry("spec/feeds/sample-rss-2.xml")
    end
    
    subject {Extractors::RSSFeedEntry.extract(@entry)}

    its(:title) { should eq "Star City"}
    its(:updated){should eq Time.new(2003, 6, 3, 11, 39, 21)}
    its(:content){should include("the International Space Station")}
  end

  context "when extracting a rss 0.91 entry" do
    before(:all) do
      @entry = load_rss_entry("spec/feeds/sample-rss-091.xml")
    end
    
    subject {Extractors::RSSFeedEntry.extract(@entry)}

    its(:title) { should eq "Giving the world a pluggable Gnutella"}
    its(:updated){should be_nil}
    its(:content){should include("WorldOS is a framework")}
  end

  context "when extracting a rss 1.0 entry" do
    before(:all) do
      @entry = load_rss_entry("spec/feeds/sample-rss-1.xml")
    end
    
    subject {Extractors::RSSFeedEntry.extract(@entry)}

    its(:title) { should eq "Processing Inclusions with XSLT"}
    its(:updated){should be_nil}
    its(:content){should include("with general XML tools")}
  end
end

private

def load_atom_entry
  feed = RSS::Parser.parse(open("spec/feeds/atom.xml").read)

  feed.entries.first
end

def load_rss_entry(source)
  feed = RSS::Parser.parse(open(source).read)

  feed.items.first
end
