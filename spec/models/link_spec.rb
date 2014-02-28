# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  body       :string(255)
#  url        :string(255)      not null
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Link do
  subject(:link) { FactoryGirl.create(:link) }
  let(:link) { FactoryGirl.create(:link) }
  let(:parent_comment) { FactoryGirl.create(:comment) }
  let(:daughter_comment) { FactoryGirl.create(:comment, parent_comment_id: parent_comment.id) }
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:subs) }
    it { should have_many(:link_subs) }
  end

  it "link comments by parent id" do
    link.comments << [parent_comment, daughter_comment]
    expect(link.comments_by_parent_id).to eq({ nil => [parent_comment], parent_comment.id => [daughter_comment]})
  end
end
