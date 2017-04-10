require 'rails_helper'

RSpec.describe 'Opposite Positions API', type: :request do
  let(:position) { create :cargo, :with_opening}
  let(:ship) { create :ship }
  let(:port) { create :port, lat: 50, lng: 50 }

  before do
    opening = position.openings.first
    create :opening, position: ship, port: port, opening_date: opening.opening_date
  end

  describe 'GET /api/v1/oppositions/:id' do

    before do
      get "/api/v1/oppositions/#{position.id}"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns json' do
      expect(response.body).to eq(ship.to_json)
    end
  end
end