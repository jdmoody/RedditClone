# == Schema Information
#
# Table name: link_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer
#  link_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link_sub do
    sub ""
    link ""
  end
end
