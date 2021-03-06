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

require 'rails_helper'

RSpec.describe Opening, type: :model do
  it { should belong_to(:position) }
  it { should belong_to(:port) }
  it { should validate_presence_of(:opening_date) }
end
