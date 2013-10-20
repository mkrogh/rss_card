require "spec_helper"
require "rss_card/services"
require "rss_card/models"

shared_examples "an atom feed" do
    it {should have(3).items} 
    its(:title) {should eq "CasaDelKrogh"}
    its("items.first.title") {should eq "Coffee"}
    its("items.first.updated") {should eq Time.new(2013,10,4)}
    its("items.first.content") {should include("Yesterday my new coffee grinder arrived")}
end

describe FeedFetcher do
  
  context "when updating an atom feed" do
    before(:all) do 
      #Cache it... waste of time to ask for it multilpe times
      @feed = update_feed("spec/feeds/atom.xml")
    end
    subject {@feed} 
    it_behaves_like "an atom feed"
    it "sets the updated time to now" do
      Time.stub(:now) {Time.new(2013,10,05,13,28,12)}
      feed = update_feed("spec/feeds/atom.xml")
      feed.updated.should == Time.new(2013,10,5,13,28,12)
    end
  end

  context "when updating with feed data input" do
    before(:all) {@feed_data = read_file("spec/feeds/atom.xml")}
    
    subject {update_feed("some_feed",@feed_data)}
    it_behaves_like "an atom feed"
  end


  context "when updating a rss 2.0 feed" do
    subject{update_feed("spec/feeds/sample-rss-2.xml")}
    its(:title) {should eq "Liftoff News"}
  end

  context "when updating a rss 0.92 feed" do
    before(:all) do
      @feed = update_feed("spec/feeds/sample-rss-092.xml")
    end
    subject{@feed}
    it {should have(22).items} 
    its(:title) {should eq "Dave Winer: Grateful Dead"}
  end

  context "when updating a rss 0.91 feed" do
    before(:all) do
      @feed = update_feed("spec/feeds/sample-rss-091.xml")
    end
    subject{@feed}
    it {should have(6).items} 
    its(:title) {should eq "WriteTheWeb"}
  end

  context "when updating a rss 1.0 feed" do
    before(:all) do
      @feed = update_feed("spec/feeds/sample-rss-1.xml")
    end
    subject{@feed}
    it {should have(2).items} 
    its(:title) {should eq "XML.com"}
  end

  context "when updating a non feed" do
    before(:all) {@feed = update_feed("spec/feeds/not_a_feed")}
    subject{@feed}
    it {should have(0).items} 
    its(:title) {should be_nil} 
  end

  context "when updating a feed with no source" do
    before(:all) {@feed = update_feed(nil)}
    subject{@feed}
    it {should have(0).items} 
    its(:title) {should be_nil} 
  end
end

private 
def update_feed(source, data=nil)
  feed = Feed.new(source)
  FeedFetcher.update(feed,data)

  feed
end
