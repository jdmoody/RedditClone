# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  moderator_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Sub do
  subject(:sub) { FactoryGirl.create(:sub) }
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:moderator_id) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "associations" do
    it { should belong_to(:moderator) }
    it { should have_many(:links) }
  end
end
