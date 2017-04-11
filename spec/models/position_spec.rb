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

require 'rails_helper'

RSpec.describe Position, type: :model do
  it { should have_many(:openings) }
  it { should have_many(:ports) }
  it { should validate_inclusion_of(:position_type).in_array(%w{Cargo Ship}) }

  describe '#search_opppositions' do

    context 'Position without opening dates' do
      subject { cargo.search_oppositions }
      let(:cargo) { create :cargo }
      it 'returns nil' do
        is_expected.to be_nil
      end
    end

    context 'Cargo' do
      subject { cargo.search_oppositions }
      let(:cargo) { create :cargo, :with_opening }

      context "Cargo and no ships" do
        it 'returns nil' do
          is_expected.to be_nil
        end
      end

      context "Cargo and 1 ship" do
        let(:ship) { create :ship }

        before do
          opening = cargo.openings.first
          create :opening, position: ship, port: opening.port, opening_date: opening.opening_date
        end

        it 'returns ship' do
          is_expected.to eq(ship)
        end
      end

      context "Cargo and 1 ship with highly different capacity" do
        let(:ship) { create :ship, hold_capacity: 100 }

        before do
          opening = cargo.openings.first
          create :opening, position: ship, port: opening.port, opening_date: opening.opening_date
        end

        it 'returns nil' do
          is_expected.to be_nil
        end
      end

      context "Cargo and 1 ship with slightly different capacity" do
        let(:ship) { create :ship, hold_capacity: 11.33 }

        before do
          opening = cargo.openings.first
          create :opening, position: ship, port: opening.port, opening_date: opening.opening_date
        end

        it 'returns ship' do
          is_expected.to eq(ship)
        end
      end

      context "Cargo and 1 ship with different opening date" do
        let(:ship) { create :ship }

        before do
          opening = cargo.openings.first
          create :opening, position: ship, port: opening.port, opening_date: opening.opening_date + 5.days
        end

        it 'returns nil' do
          is_expected.to be_nil
        end
      end

      context "Cargo and 3 ships in different ports" do

        let(:ship1) { create :ship }
        let(:ship2) { create :ship }
        let(:ship3) { create :ship }
        let(:port1) { create :port, lat: 50, lng: 50 }
        let(:port2) { create :port, lat: 30, lng: 30 }
        let(:port3) { create :port, lat: 10, lng: 5 }

        before do
          opening = cargo.openings.first
          create :opening, position: ship1, port: port1, opening_date: opening.opening_date
          create :opening, position: ship2, port: port2, opening_date: opening.opening_date
          create :opening, position: ship3, port: port3, opening_date: opening.opening_date
        end

        it 'returns ship in nearest port' do
          is_expected.to eq(ship3)
        end
      end
    end

    context 'Ship' do
      subject { ship.search_oppositions }
      let(:ship) { create :ship, :with_openings }

      context "Ship with several opening dates" do

        let(:cargo1) { create :cargo }
        let(:cargo2) { create :cargo }
        let(:cargo3) { create :cargo }

        before do
          ship.openings.each_with_index do |opening, i|
            create :opening, position: send("cargo#{i+1}"), port: opening.port, opening_date: opening.opening_date
          end
        end

        it 'returns cargo with earliest opening date' do
          is_expected.to eq(cargo1)
        end
      end
    end
  end
end
