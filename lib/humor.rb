require 'json'
require 'nokogiri'
require 'open-uri'

class Humor
  attr_reader :humor

  def initialize
    file_name = '../src/humor.json'
    scrape_for_jokes unless File.exist?(file_name)
    @humor = JSON.parse(File.read(file_name))
  end

  def scrape_for_jokes
    doc = Nokogiri::HTML(URI.open('https://www.countryliving.com/life/a27452412/best-dad-jokes/'))
    dad_jokes = []
    doc.css('.article-body-content li').each { |joke| dad_jokes.push(joke.content) }

    doc = Nokogiri::HTML(URI.open('https://bestlifeonline.com/funny-short-jokes/'))
    short_jokes = []
    doc.css('.main-content .noskimwords li').each { |joke| short_jokes.push(joke.content) }

    doc = Nokogiri::HTML(URI.open('https://www.readersdigest.ca/culture/10-short-jokes-anyone-can-remember/'))
    img_jokes = []
    doc.css('.listicle-card-image-wrapper img').each do |img|
      img_jokes.push(img.attr('src')) unless img.attr('src')[0] == 'd'
    end

    get_jokes = {
      'Dad jokes' => dad_jokes,
      'Short jokes' => short_jokes,
      'Image jokes' => img_jokes
    }
    Dir.mkdir('../src/') unless Dir.children('..').include? 'src'
    File.write('../src/humor.json', get_jokes.to_json)
  end
end
