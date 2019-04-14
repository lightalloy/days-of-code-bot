class ChallengeComments < ROM::Relation[:sql]
  schema :challenge_comments, infer: true do
    associations do
      belongs_to :user
    end
  end

  def random
    order { Sequel.lit('RANDOM()') }
  end

  def recent
    select(users[:fullname], :text).left_join(users)
  end

  def ordered_by_date
    order { date.desc }
  end

  def stats_by_user(user_id)
    select(:date, :id).where(user_id: user_id).order { date }
  end
  # def counts_by_user
  #   select { [user_id, int::count(id).as(:count)] }.group(:user_id)
  # end
end
