class SaveComment
  include Import[repo: 'repositories.challenge_comment_repo']

  TAG = 'spring2019'.freeze

  def initialize(text:, user_id:, **deps)
    @text = text
    @user_id = user_id
    super(deps)
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    repo.create attributes
  end

  private

  attr_reader :text, :user_id

  def attributes
    {
      user_id: user_id,
      tag: TAG,
      created_at: Time.now,
      date: Date.today,
      text: text.gsub("##{TAG}", '').strip
    }
  end
end
