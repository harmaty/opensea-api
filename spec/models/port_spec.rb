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

require 'rails_helper'

RSpec.describe Port, type: :model do
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lng) }
end
