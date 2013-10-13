require "spec_helper"
require "rss_card/models/feed"


describe Feed do
  
  let(:feed) {new_feed}
  context "when creating a simple feed" do
    subject {feed}
    its(:source) {should == "http://casadelkrogh.dk/atom.xml"}
    its(:title) {should == "CasaDelKrogh"}
    its(:items) {should be_empty}
    its(:updated) {should == Time.new(2013,10,5,13,16,21)}
  end
end


private
def new_feed
  feed = Feed.new("http://casadelkrogh.dk/atom.xml")
  feed.title= "CasaDelKrogh"
  feed.updated = Time.new(2013,10,5,13,16,21)

  feed
end
