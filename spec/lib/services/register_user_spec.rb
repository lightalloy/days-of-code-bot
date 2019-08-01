RSpec.describe RegisterUser do
  let(:tg_user) { double }
  let!(:repo) { Repositories::UserRepo.new }

  before do
    allow(tg_user).to receive(:id).and_return(100)
    allow(tg_user).to receive(:username).and_return('hi')
    allow(tg_user).to receive(:first_name).and_return('Anna')
    allow(tg_user).to receive(:last_name).and_return('Bu')
  end

  it "creates a new user" do
    users_count = repo.all.count
    described_class.call(tg_user)
    expect(repo.all.count - users_count).to eq(1)
  end

  it "doesn't create a user if it already exists" do
    repo.create(username: 'hi', telegram_id: '100', first_name: 'A', last_name: 'Bu')
    expect(repo.all.count).to eq(1)
    users_count = repo.all.count
    described_class.call(tg_user)
    expect(repo.all.count - users_count).to eq(0)
  end
end
