require 'bundler/setup'
require 'rom/sql/rake_task'
require 'rom-sql'

namespace :db do
  task :setup do
    opts = {
      # username: 'postgres',
      # password: 'postgres',
      encoding: 'UTF8'
    }
    config = ROM::Configuration.new(:sql, ENV.fetch('DATABASE_URL'), opts)
  end
end
