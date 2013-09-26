require "spec_helper"
require "models/feed"


describe Feed do
  
  let(:feed) {new_feed}
  context "when creating a simple feed" do
    subject {feed}
    its(:source) {should == "http://casadelkrogh.dk/atom.xml"}
    its(:title) {should == "CasaDelKrogh"}
    its(:items) {should be_empty}
  end

end


private
def new_feed
  feed = Feed.new("http://casadelkrogh.dk/atom.xml")
  feed.title= "CasaDelKrogh"

  feed
end
