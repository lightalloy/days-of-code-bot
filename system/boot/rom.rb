Application.boot(:rom) do |app|
  init do
    require 'rom'
    require 'rom-repository'
  end

  start do
    # configuration.auto_registration(app.root.join('lib/persistence'), namespace: false)

    config = ROM::Configuration.new(:sql, ENV.fetch('DATABASE_URL'), { encoding: 'UTF8' })
    config.auto_registration(app.root.join('lib'), namespace: false)

    container = ROM.container(config)

    register(:rom, container)
  end
end
