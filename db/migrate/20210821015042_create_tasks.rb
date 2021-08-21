class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string  :address
      t.string  :latitude
      t.string  :longitude
      t.string  :description
      
      t.timestamps
    end
  end
end
