require 'telegram/bot'
require 'pry'
require_relative 'boot'
require_relative 'lib/views/overall_stats'
require 'table_print'

token = ENV.fetch('BOT_TOKEN')
TAG = 'spring2019'.freeze

def rom
  @rom ||= RomContainer.instance
end

def user_repo
  @user_repo ||= UserRepo.new(rom)
end

Telegram::Bot::Client.run(token) do |bot|
  # bot.api.send_message(chat_id: 150898013, text: "Hi")
  bot.listen do |message|
    case message.text
    when '/start'
      response = "Hello, @#{message.from.username}"
      bot.api.send_message(chat_id: message.chat.id, text: response)
    when '/stats'
      response = OverallStats.new(user_repo.stats).display
      bot.api.send_message(chat_id: message.chat.id, text: response)
    when '/table_stats'
      response = "```\n#{TablePrint::Printer.new(user_repo.stats).table_print}\n```"
      bot.api.send_message(chat_id: message.chat.id, text: response, parse_mode: 'markdown')
    when "/recent", "/recent@days_of_code_bot"
      response = ChallengeCommentRepo.new(rom).recent.map(&:text).join("\n---------------------\n")
      bot.api.send_message(chat_id: message.chat.id, text: response)
    when "/reg", "/reg@days_of_code_bot"
      # result = OpenStruct.new(success?: true)
      result = RegisterUser.call(message.from, rom)
      response = result.success? ? "Спасибо, #{message.from.first_name}, вы записаны" : "#{message.from.first_name}, похоже, ты уже была записана"
      bot.api.send_message(chat_id: message.chat.id, text: response)
    when "/users", "/users@days_of_code_bot"
      response = user_repo.all.to_a.map(&:username).join("\n")
      bot.api.send_message(chat_id: message.chat.id, text: response)
      # UserRepo.new.all.to_a.map(&:username).join("/n")
    when '/help', "/help@days_of_code_bot"
      bot.api.send_message(chat_id: message.chat.id, text: 'Команды: /reg , /help, /users, /start, /recent, /stats')
    when '/stats', 'stats@days_of_code_bot'
      bot.api.send_message(chat_id: message.chat.id, text: 'Статистика')
    when /^(\s*)\#spring2019(.+)$/
      user = user_repo.by_telegram_id(message.from.id)
      if user.nil?
        response = 'Похоже, ты ещё не записалась на марафон'
      else
        result = SaveComment.call(message.text, user.id, rom)
        response = result.nil? ? 'Ошибка =(' : "Молодец, #{message.from.first_name}"
      end
      bot.api.send_message(chat_id: message.chat.id, text: response)
    when /^(\s*)\@days_of_code_bot(.+)$/
      bot.api.send_message(chat_id: message.chat.id, text: "Спасибо, #{message.from.first_name} 💙")
    else
      p message.text
    end
  end
end


