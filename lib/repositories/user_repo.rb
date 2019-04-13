require 'rom'

class UserRepo < ROM::Repository
  def create(attrs)
    users.changeset(:create, attrs).commit
  end

  def upsert(attrs)
    users.upsert(attrs)
  end

  def random
    users.random.to_a
  end

  def by_telegram_id(id)
    users.by_telegram_id(id).to_a.first
  end

  def query(conditions)
    users.where(conditions)
  end

  def stats
    users.stats
  end

  def all
    users
  end
end