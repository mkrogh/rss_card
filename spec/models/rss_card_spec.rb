require "spec_helper"
require "rss_card/models/rss_card"
require "rss_card/models/feed"
require "rss_card/models/item"


describe CardRss do
  let(:feed) {mock_feed}
  let(:card) {new_card(feed)}
  
  context "when handling a simple card" do
    subject {card}
    its(:title){should == "Feed title"}
    its(:items) {should have(3).items}
    its("items.first.title") {should == "Item 1"}
  end

  context "when updating card" do
    it "title should change with feed title" do
      card.title.should == "Feed title"
      card.update
      card.title.should == "CasaDelKrogh"
    end
  end

end


private
def mock_feed
  feed = Feed.new("spec/feeds/atom.xml")
  feed.title = "Feed title"
  feed.items << new_item("Item 1")
  feed.items << new_item("Item 2")
  feed.items << new_item("Item 3")
  feed.items << new_item("Item 4")
  feed
end

def new_item(title)
  item = Item.new
  item.title = title

  item
end

def new_card(feed)
  card = CardRss.new(feed)
  card.item_limit=3
  
  card
end
