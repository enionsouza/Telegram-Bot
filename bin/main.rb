#!/usr/bin/env ruby
# rubocop:disable Metrics/BlockLength

require 'json'
require 'telegram/bot'
require_relative '../lib/inspiration'
require_relative '../lib/humor'

quotes = Inspiration.new.inspiration
jokes = Humor.new.humor
begin
  TOKEN = File.read('../config/robot_token.txt')
rescue StandardError
  puts 'Please, refer to README.md to properly configure your robot...'
end

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: 'HTML',
        text: "Hello, <strong>#{message.from.first_name}</strong>! I'm your inspiring robot!
Please enter <strong>/help</strong> for more information!"
      )
    when '/describe'
      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: 'HTML',
        text: "<strong>I will keep you up with inspiring quotes and funny jokes!</strong>
<em>Inspirational quotes</em> are one way to help stay positive, productive, and happy as you move along your journey.
Even saying one daily motivational quote in the mirror each more can make a huge impact on your day-to-day life.
Additionally, keep in mind that old saying: <em>\"Laughter is the Best Medicine\"</em>.
Laughter strengthens your immune system, diminishes pain, and protects you from the damaging effects of stress.
<strong>So, let's keep our mood up!</strong>"
      )
    when '/help', '/menu'
      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: 'HTML',
        text: "/inspire_me - Displays a menu for Inspiring Quotes Categories
/amuse_me - Displays a menu for Jokes Categories
/fortune_cookie - Picks a Inspiring Quote randomly selected
/just_for_fun - Picks a Joke randomly selected
/describe - Presents a description of this Robot or <em>'What can this robot do?'</em>
/about - Presents information about this Robot"
      )
    when '/about'
      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: 'HTML',
        text: "<b>Microverse Capstone Project - Ruby Module</b>
<em>I will keep you up with inspiring quotes and funny jokes!</em>"
      )
    when '/fortune_cookie'
      bot.api.send_message(chat_id: message.chat.id, text: quotes[quotes.keys.sample].sample)
    when '/inspire_me'
      answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: quotes.keys, one_time_keyboard: true)
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'Please, choose one of the following categories:',
        reply_markup: answers
      )
    when '/just_for_fun'
      bot.api.send_message(chat_id: message.chat.id, text: jokes[jokes.keys.sample].sample)
    when '/amuse_me'
      answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: jokes.keys, one_time_keyboard: true)
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'Okay, fun time! Choose one of the following categories:',
        reply_markup: answers
      )
    else
      if quotes.keys.include? message.text
        bot.api.send_message(
          chat_id: message.chat.id,
          text: quotes[message.text].sample
        )
      end
      if jokes.keys.include? message.text
        bot.api.send_message(
          chat_id: message.chat.id,
          text: jokes[message.text].sample
        )
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
