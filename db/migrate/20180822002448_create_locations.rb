class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
			t.integer	:zipcode
			t.text	:weather_data
			t.timestamp	:expires_at	
      t.timestamps
    end
  end
end
