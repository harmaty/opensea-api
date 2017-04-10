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

class Position < ActiveRecord::Base

  has_many :openings, -> { order(:opening_date) }, dependent: :destroy
  has_many :ports, :through => :openings

  scope :opposite, ->(position_type) { where.not(position_type: position_type) }
  scope :capacity, ->(hold_capacity) { where(hold_capacity: hold_capacity*0.9..hold_capacity*1.1) }

  def search_oppositions
    return nil if openings.empty?

    # выбираем все противоположные позиции  совпадающие по объёму с доп. информацией по портам
    oppositions = Position.opposite(self.position_type).capacity(self.hold_capacity).joins(:ports)

    opening = openings.first
    # выбираем противоположные позиции с ближайшей датой открытия позиции
    oppositions = oppositions.where('openings.opening_date' => opening.opening_date)
    # сортируем по удалению от порта открытия позиции
    oppositions = oppositions.merge(Port.by_distance(origin: [opening.port.lat, opening.port.lng]))
    oppositions.first
  end
end
