class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations, id: :uuid do |t|
      t.string :latitude
      t.string :longitude
      t.belongs_to :location, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
