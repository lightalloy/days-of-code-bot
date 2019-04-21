require 'telegram/bot'
require 'pry'
require_relative 'boot'
require 'table_print'
require 'yaml'

token = ENV.fetch('BOT_TOKEN')
TAG = 'spring2019'.freeze

DATES = (Date.parse(ENV.fetch('DATE_START'))..Date.parse(ENV.fetch('DATE_END'))).freeze

def rom
  @rom ||= RomContainer.instance
end

def user_repo
  @user_repo ||= UserRepo.new(rom)
end

def help_text
  texts = YAML.load_file("#{__dir__}/locales/ru.yml")
  texts.fetch('ru').fetch('help')
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    next unless message.chat.id.to_s == ENV.fetch('CHAT_ID').to_s || !message.chat.id.to_s.start_with?('-')
    case message.text
    when '/start', '/start@days_of_code_bot'
      response = "Hello, @#{message.from.username}"
      bot.api.send_message(chat_id: message.chat.id, text: response)
    when '/table_stats', '/table_stats@days_of_code_bot'
      next unless user_repo.by_telegram_id(message.from.id)
      response = "```\n#{TablePrint::Printer.new(user_repo.stats).table_print}\n```"
      bot.api.send_message(chat_id: message.chat.id, text: response, parse_mode: 'markdown')
    when '/my_stats', '/my_stats@days_of_code_bot'
      user = user_repo.by_telegram_id(message.from.id)
      if user.nil?
        response = 'Похоже, ты ещё не записалась на марафон'
      else
        comment_dates = ChallengeCommentRepo.new(rom).stats_by_user(user.id)
        table = DATES.each_with_object([]) do |date, arr|
          arr.push({ date: date.strftime('%d.%m'), value: (comment_dates.include?(date) ? '+' : '-') })
        end
        response = "```\n#{TablePrint::Printer.new(table).table_print}\n```"
      end
      bot.api.send_message(chat_id: message.chat.id, text: response, parse_mode: 'markdown')
    when "/recent", '/recent@days_of_code_bot'
      # response = ChallengeCommentRepo.new(rom).recent.map(&:text).join("\n---------------------\n")
      comments = ChallengeCommentRepo.new(rom).recent
      response = "```\n#{TablePrint::Printer.new(comments).table_print}\n```"
      bot.api.send_message(chat_id: message.chat.id, text: response, parse_mode: 'markdown')
    when "/reg", '/reg@days_of_code_bot'
      next unless message.chat.id.to_s == ENV.fetch('CHAT_ID').to_s
      result = RegisterUser.call(message.from, rom)
      response = result.success? ? "Спасибо, #{message.from.first_name}, записываю 📝" : "#{message.from.first_name}, похоже, ты уже была записана"
      bot.api.send_message(chat_id: message.chat.id, text: response)
    when "/users", '/users@days_of_code_bot'
      response = user_repo.all.to_a.map(&:fullname).join("\n")
      response = 'Пока никого нет' if response.to_s.empty?
      bot.api.send_message(chat_id: message.chat.id, text: response)
    when '/help', '/help@days_of_code_bot'
      bot.api.send_message(chat_id: message.chat.id, text: help_text)
    when /^(.*)\#spring2019(.*)$/
      user = user_repo.by_telegram_id(message.from.id)
      if user.nil?
        response = 'Похоже, ты ещё не записалась на марафон'
      elsif message.text.strip.length == 11
        response = 'Нужно всё-таки что-то сделать'
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


