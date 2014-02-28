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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    title Faker::Lorem.word
    url   Faker::Internet.url
    body  Faker::Lorem.sentence

    sequence :user do |n|
      FactoryGirl.create(:user, username: "Foo#{n}")
    end

  end
end
