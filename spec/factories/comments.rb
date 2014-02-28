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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    # association :user
    sequence :user do |n|
      FactoryGirl.create(:user, username: "Bar#{n}")
    end
    association :link
    body Faker::Lorem.sentence
  end
end
