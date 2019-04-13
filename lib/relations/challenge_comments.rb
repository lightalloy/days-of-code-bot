class ChallengeComments < ROM::Relation[:sql]
  schema :challenge_comments, infer: true

  def random
    order { Sequel.lit('RANDOM()') }
  end
end
