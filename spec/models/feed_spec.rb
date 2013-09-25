require "spec_helper"
require "models/feed"


describe Feed do
  
  let(:feed) {new_feed}
  context "when simple feed" do
    subject {feed}
    its(:source) {should == "http://casadelkrogh.dk/atom.xml"}
    its(:title) {should == "CasaDelKrogh"}
  end

end


private
def new_feed
  feed = Feed.new
  feed.source= "http://casadelkrogh.dk/atom.xml"
  feed.title= "CasaDelKrogh"

  feed
end
