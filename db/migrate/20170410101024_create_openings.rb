class CreateOpenings < ActiveRecord::Migration
  def change
    create_table :openings do |t|
      t.date :opening_date
      t.references :port, index: true
      t.references :position, index: true

      t.timestamps
    end
  end
end
