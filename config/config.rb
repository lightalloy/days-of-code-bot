module DaysOfCode
  module Config
    module_function

    def env
      @_env ||= ENV.fetch('BOT_ENV', 'development')
    end
  end
end
