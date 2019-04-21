require_relative '../boot'
require 'csv'
require 'faker'

rom = RomContainer.instance
user_repo = UserRepo.new(rom)
comments_repo = ChallengeCommentRepo.new(rom)

CSV.read('db/users.csv').each do |row|
  user_repo.create({ telegram_id: row[0], username: row[1], fullname: row[2] })
end

OPTIONS = ['learned', 'solved katas in', 'developed an app in', 'hanged out with']

Date.parse(ENV.fetch('DATE_START')).upto(ENV.fetch('DATE_END')) do |date|
  user_repo.random[0, 7].each do |user|
    opt = OPTIONS.sample
    subject = opt == 'hanged out with' ? Faker::ProgrammingLanguage.creator : Faker::ProgrammingLanguage.name
    comments_repo.create(
      user_id: user.id,
      tag: 'spring2019',
      date: date,
      text: "#{opt} #{subject}"
    )
  end
end
