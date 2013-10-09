
require "spec_helper"
require "rss_card/models/item"
describe Item do

  context "when creating a simple item" do 
    let(:item){create_item}
    subject{item}
    its(:title){should == "Tracking time"}
    its(:to_s) {should == "Tracking time"}
    its(:content){should == "Short but simple content"}
    its(:updated){should == Time.new("2013","06","09")}
    its(:url){should == "http://casadelkrogh.dk/code/2013/06/09/tracking-time" }
    its(:id){should == "some_id1"}

  end
end

private
def create_item
  item = Item.new
  item.title = "Tracking time"
  item.content = "Short but simple content"
  item.updated = Time.new("2013","06","09")
  item.url = "http://casadelkrogh.dk/code/2013/06/09/tracking-time"
  item.id = "some_id1"

  item
end
