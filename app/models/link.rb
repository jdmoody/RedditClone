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
class Link < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true

  belongs_to :user
  has_many :link_subs
  has_many :subs, through: :link_subs
  has_many :comments

  def comments_by_parent_id
    return @comments_hash if @comments_hash
    comments_hash = Hash.new { |h,k| h[k] = [] }
    self.comments.each do |comment|
      comments_hash[comment.parent_comment_id] << comment
    end
    @comments_hash = comments_hash
  end
end