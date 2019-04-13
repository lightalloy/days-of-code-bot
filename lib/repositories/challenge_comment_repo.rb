require 'rom'

class ChallengeCommentRepo < ROM::Repository
  def create(attrs)
    challenge_comments.changeset(:create, attrs).commit
  end

  def random
    challenge_comments.random.to_a
  end

  def all
    challenge_comments.to_a
  end
end