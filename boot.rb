require 'bundler/setup'
require_relative 'config/config'
require 'telegram/bot'

Bundler.require(:default, DaysOfCode::Config.env)

require_relative 'lib/repositories/user_repo'
require_relative 'lib/repositories/challenge_comment_repo'
require_relative 'lib/relations/users'
require_relative 'lib/relations/challenge_comments'
require_relative 'lib/register_user'
require_relative 'lib/save_comment'
require_relative 'lib/rom_container'
require_relative 'lib/days_of_code/faraday_adapter'

Faraday::Adapter.register_middleware days_of_code_adapter: DaysOfCode::FaradayAdapter

Telegram::Bot.configure do |config|
  config.adapter = :days_of_code_adapter
end
