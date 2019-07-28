ENV['BOT_ENV'] = 'test'

require 'bundler'
require_relative '../config/config'
require 'telegram/bot'

Bundler.require

Bundler.require(:default, DaysOfCode::Config.env)
Dotenv.load(".env.#{DaysOfCode::Config.env}")

begin
  require 'pry-byebug'
rescue LoadError
end

require_relative '../system/application'

root = Application.root

Import = Application.injector
ArgsImport = Import.args

require root.join('system/boot/rom.rb')

# Faraday::Adapter.register_middleware days_of_code_adapter: DaysOfCode::FaradayAdapter

# Telegram::Bot.configure do |config|
#   config.adapter = :days_of_code_adapter
# end

Application.finalize!
