require "json"
class Item
  attr_accessor :title, :content, :updated, :url, :id

  def to_s
    "#{@title}"
  end


  def ==(o)
    o.class == self.class && o.state == self.state
  end
  alias_method :eql?, :==

  def hash
    state.hash
  end

  def to_json(*a)
    {
      item: {
        title: @title,
        content: @content,
        url: @url,
        id: @id,
        updated: @updated
      }
    }.to_json(*a)
  end

  def self.from_json(json)
    if json.is_a?(Hash)
      obj = json["item"]
    else
      obj = JSON.parse(json)["item"]
    end
    item = new
    item.title = obj['title']
    item.content = obj['content']
    item.url = obj['url']
    item.id = obj['id']
    item.updated = Time.parse(obj['updated'])
    item
  end

  protected
  def state
    [@title, @content, @url, @id,@updated]
  end
end
