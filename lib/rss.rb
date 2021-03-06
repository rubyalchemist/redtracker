require 'nokogiri'
require 'open-uri'

class Rss
  Item = Struct.new(:title,:link,:description,:created_at)
  attr_accessor :feed_url, :feed
  def initialize(feed)
    @feed_url = feed
    @feed = Nokogiri::XML(open(@feed_url))
    @raw_items = @feed.xpath('//item')
    @items = @raw_items.collect{|i| Item.new(i.xpath('title').text,i.xpath('link').text, i.xpath('description').text,Time.parse(i.xpath('pubDate').text))}
  end

  def items(raw=false)
    raw ? @raw_items : @items
  end
end
