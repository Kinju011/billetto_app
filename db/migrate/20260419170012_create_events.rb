class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.string :image_url
      t.string :external_id

      t.timestamps
    end
  end
end
