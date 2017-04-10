class CreatePorts < ActiveRecord::Migration
  def change
    create_table :ports do |t|
      t.string :title
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
