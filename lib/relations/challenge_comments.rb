class ChallengeComments < ROM::Relation[:sql]
  schema :challenge_comments, infer: true

  def random
    order { Sequel.lit('RANDOM()') }
  end

  def ordered_by_date
    order { date.desc }
  end

  # def counts_by_user
  #   select { [user_id, int::count(id).as(:count)] }.group(:user_id)
  # end
end
