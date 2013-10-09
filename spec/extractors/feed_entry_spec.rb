require "spec_helper"
require "rss"
require "rss_card/extractors"

describe  Extractors::AtomFeedEntry do

  context "when extracting an atom entry" do
    before(:all) do
      @entry = load_atom_entry
    end
    
    subject {Extractors::AtomFeedEntry.extract(@entry)}

    its(:title) { should eq "Coffee"}
    its(:updated){should eq Time.new(2013,10,04)}
    its(:content){should include("conical burr grinder")}
    its(:url){should eq "http://casadelkrogh.dk/Other/2013/10/04/coffee"}
  end

  context "when extracting a rss 2.0 entry" do
    before(:all) do
      @entry = load_rss_entry("spec/feeds/sample-rss-2.xml")
    end
    
    subject {Extractors::RSSFeedEntry.extract(@entry)}

    its(:title) { should eq "Star City"}
    its(:updated){should eq Time.new(2003, 6, 3, 11, 39, 21)}
    its(:content){should include("the International Space Station")}
    its(:url){should eq "http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp"}
  end

  context "when extracting a rss 0.91 entry" do
    before(:all) do
      @entry = load_rss_entry("spec/feeds/sample-rss-091.xml")
    end
    
    subject {Extractors::RSSFeedEntry.extract(@entry)}

    its(:title) { should eq "Giving the world a pluggable Gnutella"}
    its(:updated){should be_nil}
    its(:content){should include("WorldOS is a framework")}
    its(:url){should eq "http://writetheweb.com/read.php?item=24"}
  end

  context "when extracting a rss 1.0 entry" do
    before(:all) do
      @entry = load_rss_entry("spec/feeds/sample-rss-1.xml")
    end
    
    subject {Extractors::RSSFeedEntry.extract(@entry)}

    its(:title) { should eq "Processing Inclusions with XSLT"}
    its(:updated){should be_nil}
    its(:content){should include("with general XML tools")}
    its(:url){should eq "http://xml.com/pub/2000/08/09/xslt/xslt.html"}
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
