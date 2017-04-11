class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title
      t.string :position_type, index: true
      t.float :hold_capacity

      t.timestamps
    end
  end
end
