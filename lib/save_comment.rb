class SaveComment
  TAG = '#spring2019'.freeze

  def initialize(text, user_id, rom)
    @text = text
    @user_id = user_id
    @rom = rom
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    repo.create(attributes)
  end

  private

  attr_reader :text, :user_id, :rom

  def attributes
    {
      user_id: user_id,
      tag: TAG,
      date: Date.today,
      text: text.gsub('##{TAG}', '')
    }
  end

  def repo
    ChallengeCommentRepo.new(rom)
  end
end
