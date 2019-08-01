class RegisterUser
  include Import[repo: 'repositories.user_repo']

  def self.call(*args)
    new.call(*args)
  end

  def call(tg_user)
    id = repo.upsert(telegram_id: tg_user.id,
                     username: tg_user.username,
                     fullname: [tg_user.first_name, tg_user.last_name].join(' '))
    result.new(success?: !id.nil?)
  end

  private

  def result
    Struct.new(:success?, keyword_init: true)
  end
end
