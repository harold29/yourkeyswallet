class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :address_1
      t.string :address_2
      t.string :country
      t.string :country_code
      t.string :state
      t.string :state_code
      t.integer :zipcode
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
