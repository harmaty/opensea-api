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

FactoryGirl.define do
  factory :opening do
    position
    port
    opening_date { Date.today }
  end
end
