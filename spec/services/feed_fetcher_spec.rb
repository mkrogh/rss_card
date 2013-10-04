require "spec_helper"
require "services/feed_fetcher"
require "models/feed"

describe FeedFetcher do
  
  context "when updating an atom feed" do
    before(:all) do 
      #Cache it... waste of time to ask for it multilpe times
      @feed = update_feed("spec/feeds/atom.xml")
    end
    subject {@feed} 
    it {should have(3).items} 
    its(:title) {should eq "CasaDelKrogh"}
    its("items.first.title") {should eq "Coffee"}
    its("items.first.updated") {should eq Time.new(2013,10,4)}
    its("items.first.content") {should include("Yesterday my new coffee grinder arrived")}
  end


  context "when updating a rss 2.0 feed" do
    subject{update_feed("spec/feeds/sample-rss-2.xml")}
    its(:title) {should eq "Liftoff News"}
  end

  context "when updating a rss 0.92 feed" do
    subject{update_feed("spec/feeds/sample-rss-092.xml")}
    it {should have(22).items} 
    its(:title) {should eq "Dave Winer: Grateful Dead"}
  end

  context "when updating a rss 0.91 feed" do
    subject{update_feed("spec/feeds/sample-rss-091.xml")}
    it {should have(6).items} 
    its(:title) {should eq "WriteTheWeb"}
  end

  context "when updating a rss 1.0 feed" do
    subject{update_feed("spec/feeds/sample-rss-1.xml")}
    it {should have(2).items} 
    its(:title) {should eq "XML.com"}
  end

  context "when updating a non feed" do
    subject{update_feed("spec/feeds/not_a_feed")}
    it {should have(0).items} 
    its(:title) {should be_nil} 
  end

  context "when updating a feed with no source" do
    subject{update_feed(nil)}
    it {should have(0).items} 
    its(:title) {should be_nil} 
  end
end

private 
def update_feed(source)
  feed = Feed.new(source)
  FeedFetcher.update(feed)

  feed
end
