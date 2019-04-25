module DaysOfCode
  module Config
    def env
      @_env ||= ENV.fetch('BOT_ENV', 'development')
    end
  end
end
