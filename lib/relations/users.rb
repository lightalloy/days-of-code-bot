class Users < ROM::Relation[:sql]
  schema :users, infer: true do
    associations do
      has_many :challenge_comments
    end
  end

  def by_telegram_id(telegram_id)
    where(telegram_id: telegram_id)
  end

  def random
    order { Sequel.lit('RANDOM()') }
  end

  def stats
    select(:id, :username, :fullname, challenge_comments[:id].func { integer::count(id).as(:count) }).
    left_join(challenge_comments).
    group(:id)
  end
end
