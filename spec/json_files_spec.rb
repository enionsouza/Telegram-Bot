# rubocop:disable Metrics/BlockLength

require 'json'
require 'spec_helper'
require_relative '../lib/humor'
require_relative '../lib/inspiration'

quotes = Inspiration.new.inspiration
jokes = Humor.new.humor

RSpec.describe 'Sanity testing the automatically created \'json\' files' do
  context 'Checking Inspiration module web scraping result' do
    describe 'to \'https://www.shopify.com/blog/motivational-quotes\'' do
      it 'Quantity of scraped categories...' do
        expect(quotes.keys.length).to eql(23)
      end

      it 'Quantity of \'Deep motivational quotes\'' do
        expect(quotes['Deep motivational quotes'].length).to eql(7)
      end

      it 'Quantity of \'Motivational quotes for success\'' do
        expect(quotes['Motivational quotes for success'].length).to eql(10)
      end

      it 'Quantity of \'Motivational quotes for life\'' do
        expect(quotes['Motivational quotes for life'].length).to eql(4)
      end

      it 'Quantity of \'Motivational quotes for work\'' do
        expect(quotes['Motivational quotes for work'].length).to eql(8)
      end

      it 'Quantity of \'Motivational quotes for women\'' do
        expect(quotes['Motivational quotes for women'].length).to eql(15)
      end

      it 'Quantity of \'Motivational quotes for men\'' do
        expect(quotes['Motivational quotes for men'].length).to eql(8)
      end

      it 'Quantity of \'Motivational quotes for students\'' do
        expect(quotes['Motivational quotes for students'].length).to eql(5)
      end

      it 'Quantity of \'Team motivational quotes\'' do
        expect(quotes['Team motivational quotes '].length).to eql(7)
      end

      it 'Quantity of \'Short motivational quotes\'' do
        expect(quotes['Short motivational quotes'].length).to eql(7)
      end

      it 'Quantity of \'Motivational Monday quotes\'' do
        expect(quotes['Motivational Monday quotes'].length).to eql(8)
      end

      it 'Quantity of \'Friday motivational quotes\'' do
        expect(quotes['Friday motivational quotes'].length).to eql(5)
      end

      it 'Quantity of \'Best motivational quotes to start your day\'' do
        expect(quotes['Best motivational quotes to start your day'].length).to eql(7)
      end

      it 'Quantity of \'Positive quotes for motivation\'' do
        expect(quotes['Positive quotes for motivation '].length).to eql(10)
      end

      it 'Quantity of \'Daily motivational quotes\'' do
        expect(quotes['Daily motivational quotes'].length).to eql(12)
      end

      it 'Quantity of \'Inspirational quotes\'' do
        expect(quotes['Inspirational quotes'].length).to eql(11)
      end

      it 'Quantity of \'Positive quotes\'' do
        expect(quotes['Positive quotes'].length).to eql(5)
      end

      it 'Quantity of \'Encouraging quotes\'' do
        expect(quotes['Encouraging quotes'].length).to eql(7)
      end

      it 'Quantity of \'Motivation quotes\'' do
        expect(quotes['Motivation quotes'].length).to eql(8)
      end

      it 'Quantity of \'Quotes about life\'' do
        expect(quotes['Quotes about life'].length).to eql(10)
      end

      it 'Quantity of \'Best motivational quotes\'' do
        expect(quotes['Best motivational quotes'].length).to eql(14)
      end

      it 'Quantity of \'Inspirational new year quotes\'' do
        expect(quotes['Inspirational new year quotes'].length).to eql(15)
      end

      it 'Quantity of \'Quotes about success\'' do
        expect(quotes['Quotes about success'].length).to eql(12)
      end
    end
  end

  context 'Checking Humor module web scraping result' do
    describe 'Quantity of scraped categories...' do
      it 'three websites have been scraped' do
        expect(jokes.keys.length).to eql(3)
      end
    end

    describe 'to \'https://www.countryliving.com/life/a27452412/best-dad-jokes/\'' do
      it 'Quantity of \'Dad jokes\'' do
        expect(jokes['Dad jokes'].length).to eql(145)
      end
    end

    describe 'to \'https://bestlifeonline.com/funny-short-jokes/\'' do
      it 'Quantity of \'Short jokes\'' do
        expect(jokes['Short jokes'].length).to eql(50)
      end
    end

    describe 'to \'https://www.readersdigest.ca/culture/10-short-jokes-anyone-can-remember/\'' do
      it 'Quantity of \'Image jokes\'' do
        expect(jokes['Image jokes'].length).to eql(75)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
