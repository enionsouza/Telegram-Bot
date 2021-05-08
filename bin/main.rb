#!/usr/bin/env ruby
# rubocop:disable Metrics/BlockLength

require 'json'
require 'telegram/bot'
require_relative '../lib/robot'
# require_relative '../lib/inspiration'
# require_relative '../lib/humor'

# quotes = Inspiration.new.inspiration
# jokes = Humor.new.humor
quotes = JSON.parse(File.read('../src/inspiration.json'))
jokes = JSON.parse(File.read('../src/humor.json'))

Telegram::Bot::Client.run(CapstoneRobot.token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/help', '/menu'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "/inspire_me - Displays a menu for Inspiring Quotes Categories
/amuse_me - Displays a menu for Jokes Categories
/fortune_cookie - Presents a Inspiring Quote randomly selected
/just_for_fun - Presents a Joke randomly selected"
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
