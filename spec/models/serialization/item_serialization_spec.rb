require "spec_helper"
require "rss_card/models/item"
require "json"

describe Item do
  
  let(:item){create_item}

  context "when serializing item" do
    subject{JSON.parse(item.to_json)["item"]}
    its(["title"]) {should == item.title}
    its(["content"]) {should == item.content}
    its(["url"]) {should == item.url}
    its(["id"]) {should == item.id}
    its(["updated"]) {should == item.updated.to_s}
  end

  context "when deserializing item" do
    subject{Item.from_json(item.to_json)}
    its(:title) {should == item.title}
    its(:content) {should == item.content}
    its(:url) {should == item.url}
    its(:id) {should == item.id}
    its(:updated){should be_within(1).of(item.updated)}
  end


end
