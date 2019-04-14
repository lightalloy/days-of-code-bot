require 'rom'

class ChallengeCommentRepo < ROM::Repository
  def create(attrs)
    challenge_comments.changeset(:create, attrs).commit
  end

  def recent
    challenge_comments.recent.ordered_by_date.limit(20).to_a
    # challenge_comments.ordered_by_date.limit(20).to_a
  end

  def random
    challenge_comments.random.to_a
  end

  def stats_by_user(user_id)
    challenge_comments.stats_by_user(user_id).to_a.map(&:date).uniq
  end

  def all
    challenge_comments.to_a
  end
end