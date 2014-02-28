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

class Sub < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :moderator_id, presence: true

  belongs_to :moderator, class_name: "User"
  has_many :link_subs
  has_many :links, through: :link_subs, inverse_of: :subs
end
