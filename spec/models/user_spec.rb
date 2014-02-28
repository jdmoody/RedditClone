# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  email           :string(255)
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  let(:invalid_user) { FactoryGirl.build(:user, username: "",
                                                password_digest: "",
                                                session_token: "")}

  it "does not store the password" do
    user.password.should be_nil
  end

  context "For invalid users" do
    it "validates presence of username" do
      expect(invalid_user).to have(1).error_on(:username)
    end

    it "validates presence of password_digest" do
      expect(invalid_user).to have(1).error_on(:password_digest)
    end

    it "validates presence of session_token" do
      expect(invalid_user).to have(0).errors_on(:session_token)
    end

    it "validates that the length of the password is at least 6" do
      user.password = "flute"
      expect(user).not_to be_valid
    end
  end

  it "validates uniquness of username" do
    user1 = FactoryGirl.create(:user, username: "Jon")
    user2 = FactoryGirl.build(:user, username: "Jon")

    expect(user2).not_to be_valid
  end

  it "validates a valid user" do
    expect(user).to be_valid
  end

  it "finds a user by credentials" do
    user_params = { username: user.username, password: "password", email: "foo@example.com" }
    found_user = User.find_by_credentials(user_params)
    expect(found_user).to eq user
  end

  describe "resetting session token" do
    it "it resets the session token correctly" do
      old_token = user.session_token
      user.reset_session_token
      expect(user.session_token).not_to eq old_token
    end

    it "saves the new session token correctly" do
      old_token = user.session_token
      user.reset_session_token
      expect(User.find_by(session_token: old_token)).to be_nil
    end
  end

  describe "authentication" do
    it "recognizes a correct password" do
      expect(user.is_password?("password")).to be true
    end

    it "does not recognize an incorrect password" do
      expect(user.is_password?("something_else")).to be false
    end
  end


end
