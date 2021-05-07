#!/usr/bin/env ruby

require 'json'
require 'telegram/bot'
require_relative '../lib/robot'
require_relative '../lib/inspiration'

quotes = Inspiration.new.inspiration

Telegram::Bot::Client.run(CapstoneRobot.token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/fortune_cookie'
      bot.api.send_message(chat_id: message.chat.id, text: quotes[quotes.keys.sample].sample)
    when '/inspire_me'
      answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: quotes.keys, one_time_keyboard: true)
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'Please, choose one of the following categories:',
        reply_markup: answers
      )
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    else
      if quotes.keys.include? message.text
        bot.api.send_message(
          chat_id: message.chat.id,
          text: quotes[message.text].sample
        )
      end
    end
  end
end
