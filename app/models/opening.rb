# == Schema Information
#
# Table name: openings
#
#  id           :integer          not null, primary key
#  opening_date :date
#  port_id      :integer
#  position_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Opening < ActiveRecord::Base
  belongs_to :port
  belongs_to :position

  validates_presence_of :opening_date
end
