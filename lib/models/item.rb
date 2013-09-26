
class Item
  attr_accessor :title, :content, :updated, :url, :id

  def to_s
    "#{@title}"
  end
end
