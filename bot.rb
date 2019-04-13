 require 'telegram/bot'
require 'pry'

token = ENV.fetch('BOT_TOKEN')
TAG = 'spring2019'.freeze

Telegram::Bot::Client.run(token) do |bot|
  # bot.api.send_message(chat_id: 150898013, text: "Hi")
  bot.listen do |message|
    case message.text
    when '/start'
     # p message.chat.id
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/history'
      # p message.chat.id
      # messages = bot.api.get_history(chat_id: message.chat.id, limit: 5, offset: 100, max_id: 1)
      # bot.api.send_message(messages)
    when "/reg"
      bot.api.send_message(chat_id: message.chat.id, text: "Спасибо, #{message.from.first_name}, вы записаны")
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, text: "Команды: /reg , /help")
    when /^(\s*)\#spring2019(.+)$/
      bot.api.send_message(chat_id: message.chat.id, text: "Молодец, #{message.from.first_name}")
    when /^(\s*)\@days_of_code_bot(.+)$/
      bot.api.send_message(chat_id: message.chat.id, text: "Спасибо, #{message.from.first_name} 💙")
    else
      binding.pry
      p message.text
    end
  end
end



