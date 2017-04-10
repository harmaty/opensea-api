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

FactoryGirl.define do
  factory :port do
    lat 0
    lng 0
  end
end
