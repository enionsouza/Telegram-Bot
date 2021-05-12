#!/usr/bin/env ruby

require 'json'
require 'telegram/bot'
require_relative '../lib/inspiration'
require_relative '../lib/humor'

def start(bot, id, first_name)
  bot.api.send_message(
    chat_id: id,
    parse_mode: 'HTML',
    text: "Hello, <strong>#{first_name}</strong>! I'm your inspiring robot!
Please enter <strong>/help</strong> for more information!"
  )
end

def describe(bot, id)
  bot.api.send_message(
    chat_id: id,
    parse_mode: 'HTML',
    text: "<strong>I will keep you up with inspiring quotes and funny jokes!</strong>
<em>Inspirational quotes</em> are one way to help you to stay positive and productive as you move along your journey.
Even saying one motivational quote to yourself in front of the mirror every day can make a huge impact on your life.
Additionally, keep in mind that old saying: \"Laughter is the Best Medicine\".
Laughter strengthens your immune system, diminishes pain, and protects you from the damaging effects of stress.
<strong>So, let's keep our attitude up!</strong>"
  )
end

def help(bot, id)
  bot.api.send_message(
    chat_id: id,
    parse_mode: 'HTML',
    text: "/inspire_me - Displays a menu for Inspiring Quotes Categories
/amuse_me - Displays a menu for Jokes Categories
/fortune_cookie - Picks a Inspiring Quote randomly selected
/just_for_fun - Picks a Joke randomly selected
/describe - Presents a description of this Robot or <em>'What can this robot do?'</em>
/about - Presents information about this Robot"
  )
end

def about(bot, id)
  bot.api.send_message(
    chat_id: id,
    parse_mode: 'HTML',
    text: "<b>Microverse Capstone Project - Ruby Module</b>
<em>I will keep you up with inspiring quotes and funny jokes!</em>"
  )
end

def send_message(bot, id, message)
  bot.api.send_message(chat_id: id, text: message)
end

def menu(bot, id, options)
  bot.api.send_message(
    chat_id: id,
    text: 'Please, choose one of the following categories:',
    reply_markup: options
  )
end

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
      start(bot, message.chat.id, message.from.first_name)
    when '/describe'
      describe(bot, message.chat.id)
    when '/help'
      help(bot, message.chat.id)
    when '/about'
      about(bot, message.chat.id)
    when '/fortune_cookie'
      send_message(bot, message.chat.id, quotes[quotes.keys.sample].sample)
    when '/inspire_me'
      options = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: quotes.keys, one_time_keyboard: true)
      menu(bot, message.chat.id, options)
    when '/just_for_fun'
      send_message(bot, message.chat.id, jokes[jokes.keys.sample].sample)
    when '/amuse_me'
      options = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: jokes.keys, one_time_keyboard: true)
      menu(bot, message.chat.id, options)
    else
      send_message(bot, message.chat.id, quotes[message.text].sample) if quotes.keys.include? message.text
      send_message(bot, message.chat.id, jokes[message.text].sample) if jokes.keys.include? message.text
    end
  end
end
