require 'rom'

class UserRepo < ROM::Repository
  def create(attrs)
    users.changeset(:create, attrs).commit
  end

  def upsert(attrs)
    users.upsert(attrs)
  end

  def query(conditions)
    users.where(conditions)
  end

  def all
    users
  end
end