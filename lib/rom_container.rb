module RomContainer
  module_function

  def instance
    config = ROM::Configuration.new(:sql, ENV.fetch('DATABASE_URL'), { encoding: 'UTF8' })
    config.register_relation(Users)
    config.register_relation(ChallengeComments)
    @rom = ROM.container(config)
  end
end