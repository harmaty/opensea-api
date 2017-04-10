# == Schema Information
#
# Table name: positions
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  position_type :string(255)
#  hold_capacity :float
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :position do
    title { Faker::Lorem.word }
    hold_capacity { 11.5 }

    factory :ship do
      position_type 'Ship'
    end

    factory :cargo do
      position_type 'Cargo'
    end

    trait :with_opening do
      after(:create) do |position|
        create_list(:opening, 1, position: position)
      end
    end

    trait :with_openings do
      after(:create) do |position|
        3.times do |i|
          port = create :port, lat: i*10, lng: i*10
          create(:opening, position: position, port: port, opening_date: Date.today + i.days )
        end
      end
    end
  end
end
