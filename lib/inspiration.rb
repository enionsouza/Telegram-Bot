require 'json'
require 'nokogiri'
require 'open-uri'

class Inspiration
  attr_reader :inspiration

  def initialize
    file_name = '../src/inspiration.json'
    inspire_me unless File.exist?(file_name)
    @inspiration = JSON.parse(File.read(file_name))
  end

  def inspire_me
    doc = Nokogiri::HTML(URI.open('https://www.shopify.com/blog/motivational-quotes'))
    get_inspiration = {}

    23.times do |i|
      quotes = []
      doc.css("##{i + 1} + ol > li", "##{i + 1} + div + ol > li", "##{i + 1} + p + ol > li").each do |link|
        quotes << link.content
      end
      get_inspiration[doc.css("##{i + 1}").inner_html] = quotes
    end

    Dir.mkdir('../src/') unless Dir.directory?('../src/')
    File.write('../src/inspiration.json', get_inspiration.to_json)
  end
end


