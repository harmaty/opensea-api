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

  has_many :openings, dependent: :destroy
  has_many :ports, :through => :openings

  scope :opposite, ->(position_type) { where.not(position_type: position_type) }
  scope :capacity, ->(hold_capacity) { where(hold_capacity: hold_capacity*0.9..hold_capacity*1.1 ) }

  def search_oppositions
    # выбираем все противоположные позиции  совпадающие по объёму с доп. информацией по портам
    oppositions = Position.opposite(self.position_type).capacity(self.hold_capacity).joins(:ports)

    # Для каждой даты открытия позиции ищем ближайщую противоположную позицию
    openings.map do |opening|
      oppositions.where('openings.opening_date' => opening.opening_date)
          .merge(Port.by_distance(origin: [opening.port.lat, opening.port.lng])).first
    end.compact
  end
end
