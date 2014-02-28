# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  link_id           :integer          not null
#  parent_comment_id :integer
#  body              :string(255)      not null
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Comment do
  subject(:comment) { FactoryGirl.create(:comment) }
  describe "validations" do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:link_id) }
  end

  describe "associations" do
    it { should belong_to(:parent_comment) }
    it { should belong_to(:user) }
    it { should belong_to(:link) }
    it { should have_many(:daughter_comments) }
  end
end
