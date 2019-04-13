class RegisterUser
  def initialize(tg_user, rom)
    @tg_user = tg_user
    @rom = rom
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    id = repo.upsert(telegram_id: tg_user.id,
                     username: tg_user.username,
                     fullname: [tg_user.first_name, tg_user.last_name].join(' '))
    OpenStruct.new(success?: !id.nil?)
  end

  private

  attr_reader :tg_user, :rom

  def repo
    UserRepo.new(rom)
  end
end
