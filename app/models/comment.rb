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

class Comment < ActiveRecord::Base
  validates :body, presence: true
  validates :user_id, presence: true
  validates :link_id, presence: true

  belongs_to :user
  belongs_to :link
  belongs_to :parent_comment, class_name: "Comment"
  has_many :daughter_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id


end
