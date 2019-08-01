module Repositories
  class UserRepo < ROM::Repository[:users]
    include ArgsImport['rom']

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

    # TODO: move the "view" logic out of the repo
    def stats
      users.stats.to_a.map { |row| { name: (row.fullname || row.username).strip, progress: "#{'+' * row.count } (#{row.count})" } }
    end

    def all
      users
    end
  end
end
