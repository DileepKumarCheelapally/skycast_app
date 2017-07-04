class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
