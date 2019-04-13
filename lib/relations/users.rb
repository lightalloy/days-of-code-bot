class Users < ROM::Relation[:sql]
  schema :users, infer: true

  def by_telegram_id(telegram_id)
    where(telegram_id: telegram_id)
  end

  def random
    order { Sequel.lit('RANDOM()') }
  end
end
