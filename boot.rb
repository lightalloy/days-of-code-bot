require 'bundler/setup'
require 'rom-sql'
require "#{__dir__}/lib/repositories/user_repo"
require 'pry'
require "#{__dir__}/lib/relations/users"
require "#{__dir__}/lib/relations/challenge_comments"
require "#{__dir__}/lib/register_user"