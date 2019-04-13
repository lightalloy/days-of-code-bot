class ChallengeComments < ROM::Relation[:sql]
  schema :challenge_comments, infer: true

  def random
    order { Sequel.lit('RANDOM()') }
  end

  def ordered_by_date
    order { date.desc }
  end
end
