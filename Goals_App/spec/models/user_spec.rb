require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "#is_password?" do 
    it "verifies password is correct" do 
      expect(user.is_password?('whatever')).to eq(true)
    end

    it "verifies password is incorrect" do 
      expect(user.is_password?('nowiefhbej')).to eq(false)
    end
  end

  describe "#reset_session_token!" do 
    it "resets the user's session token" do
      old_session_token = user.session_token 
      new_session_token = user.reset_session_token!
      expect(user.session_token).to eq(new_session_token)
      expect(user.session_token).to_not eq(old_session_token)

    end
  end

  describe "::find_by_credentials" do
    let(:user) { User.new(username: 'username', password: 'password') }
    before(:each) do
      user.save!
    end

    it "returns a user given correct credentials" do 
      expect(User.find_by_credentials("username", "password")).to eq(user)
    end

    it "returns nil given incorrect credentials" do
      expect(User.find_by_credentials("dfgsklmn;adfs", "nopaqpadfs")).to eq(nil)
    end
  end

end