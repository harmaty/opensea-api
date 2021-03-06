# == Schema Information
#
# Table name: ports
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  lat        :float
#  lng        :float
#  created_at :datetime
#  updated_at :datetime
#

class Port < ActiveRecord::Base
  acts_as_mappable

  validates_presence_of :lat, :lng
end
