require "spec_helper"
require "rss_card/models/rss_card"
require "json"

describe CardRss do
  let(:card){create_card}

  context "serializing card to json" do
    subject {get_json_obj(card)}
    it {should have(3)["items"]}
    its(["title"]) {should == "CasaDelKrogh"}
  end

  def get_json_obj(card)
    JSON.parse(card.to_json)["card"]
  end

  def create_card
    feed = feed_from_file("spec/feeds/atom.xml")
    card = CardRss.new(feed) 
  end
end
