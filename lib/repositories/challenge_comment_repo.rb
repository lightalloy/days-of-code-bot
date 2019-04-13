require 'rom'

class ChallengeCommentRepo < ROM::Repository
  def create(attrs)
    challenge_comments.changeset(:create, attrs).commit
  end

  def recent
    challenge_comments.ordered_by_date.limit(20).to_a
  end

  def random
    challenge_comments.random.to_a
  end

  # def stats
  #   challenge_comments.counts_by_user.to_a
  # end

  def all
    challenge_comments.to_a
  end
end