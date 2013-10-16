require "spec_helper"
require "rss_card/models/feed"
require "json"


describe Feed do
  let(:feed){feed_from_file("spec/feeds/atom.xml")}
  context "serializing feed to json" do
    subject {get_json_obj(feed)}
    its(["title"]) {should == "CasaDelKrogh"}
    its(["source"]) {should == "spec/feeds/atom.xml"}
    its(["updated"]) {should == feed.updated.to_s}
    it {should have(3)['items']}
  end

  context "deserializing feed" do
    subject {Feed.from_json(feed.to_json)}
    its(:source) {should == feed.source}
    its(:title) {should == feed.title}
    its(:updated) {should be_within(1).of(feed.updated)}
    its(:items){should == feed.items}
  end 


  def get_json_obj(feed)
    JSON.parse(feed.to_json)["feed"]
  end
end


