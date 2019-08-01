require 'bundler'
require_relative '../config/config'
require 'telegram/bot'
require_relative '../lib/days_of_code/faraday_adapter'

Bundler.require(:default, DaysOfCode::Config.env)
Dotenv.load(".env.#{DaysOfCode::Config.env}")

begin
  require 'pry-byebug'
rescue LoadError
end

require_relative 'application'

root = Application.root

Import = Application.injector
ArgsImport = Import.args

Dir.glob(root.join('system/boot/*.rb')).each { |f| require f }

Faraday::Adapter.register_middleware days_of_code_adapter: DaysOfCode::FaradayAdapter

Telegram::Bot.configure do |config|
  config.adapter = :days_of_code_adapter
end

Application.finalize!
