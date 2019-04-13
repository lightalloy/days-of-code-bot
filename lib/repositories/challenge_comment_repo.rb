require 'rom'

class ChallengeCommentRepo < ROM::Repository
  def create(attrs)
    challenge_comments.changeset(:create, attrs).commit
  end

  def all
    challenge_comments.to_a
  end
end