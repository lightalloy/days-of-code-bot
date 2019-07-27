RSpec.describe RegisterUser do
  # subject(:beer_service) { described_class.new(repo: beer_repo) }
  # let(:beer_repo) { instance_double(Repositories::BeerRepo) }
  # let(:user_id) { 'whatever' }

  # describe '#drink' do
  #   it 'creates new drunk beer' do
  #     expect(beer_repo).to receive(:create)

  #     beer_service.drink(user_id)
  #   end
  # end

  let(:tg_user) { double }

  before do
    allow(:tg_user).to receive(:id).and return(100)
    allow(:tg_user).to receive(:username).and return('hi')
    allow(:tg_user).to receive(:first_name).and return('Anna')
    allow(:tg_user).to receive(:last_name).and return('Bu')
  end

  it "registers a user" do
    described_class.
  end
end
