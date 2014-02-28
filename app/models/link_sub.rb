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

class LinkSub < ActiveRecord::Base
  belongs_to :link
  belongs_to :sub
end
